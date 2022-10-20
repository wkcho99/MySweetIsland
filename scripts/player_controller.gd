#Johann Massyn, 23/06/2019
#Godot (3.1) 3D Player movement script

#Atatch script to 3d node with following structure
#Kinematic body: Player
#  - CollisionShape: CollisionShape
#  - Camera: Camera

extends KinematicBody

export (bool) var can_move = true #Alow player to input movment.
export (bool) var can_sprint = true #Alow player to toggle sprint movment.
export (float) var move_speed = 8.0 #Players movement speed
export (float) var move_speed_sprint = 16.0 #Players sprint movement speed
export (bool) var move_sprint = false #Player sprinting toggle
export (float) var move_acceleration = 7.0 #Players acceleration to movment speed 
export (float) var move_deacceleration = 10.0 #Players deacceleration from movment speed
export (bool) var mouse_captured = true #Toggles mouse captured mode
export (float) var mouse_sensitivity_x = 0.3 #Mouse sensitivity X axis
export (float) var mouse_sensitivity_y = 0.3 #Mouse sensitivity Y axis
export (float) var mouse_max_up = 90.0 #Mouse max look angle up
export (float) var mouse_max_down = -80.0 #Mouse max look angle down
export (float) var Jump_speed = 6.0 #Players jumps speed
export (bool) var allow_fall_input = true #Alow player to input movment when falling
export (bool) var stop_on_slope = false #Toggle sliding on slopes
export (float) var max_slides = 4.0 #Maximum of slides
export (float) var floor_max_angle = 60.0 #Maximum slop angle player can traverse
export (bool) var infinite_inertia = false #Toggle infinite inertia
export (float) var gravaty = 9.81 #Gravaty acceleration
export (Vector3) var gravaty_vector = Vector3(0, -1, 0) #Gravaty normal direction vector
export (Vector3) var floor_normal = Vector3(0, 1, 0) #Floor normal direction vector
export (Vector3) var jump_vector = Vector3(0, 1, 0) #Jump normal direction vector
export (Vector3) var velocity = Vector3(0, 0, 0) #Initial velocity

export (int) var CAMERA_X_ROT_MIN = -30
export (int) var CAMERA_X_ROT_MAX = 30
export (float) var CAMERA_MOUSE_ROTATION_SPEED = 0.001
export (int) var FORWARD_OFFSET = 10
export (int) var STRAFE_OFFSET = 3
export (int) var HEIGHT_DELTA_SPEED = 10
var BUILDINGS = ["wall", "floor", "roof"]
var building_index = 0
var placing_instance
var building_type = load("res://objects/buildings/" + BUILDINGS[building_index] + ".tscn")
var is_placing = false
var camera_x_rot = 0.0
var animation_player
var time = 0 # time in seconds
var time_when_actionable = 0 # time in seconds
var last_time_hit = -2000
var hit = false
onready var inventory: InventoryStacked
var br : InventoryItem
var is_inven_open = false
# onready var camera_base = $CameraBase
# onready var camera_animation = camera_base.get_node(@"Animation")
# onready var camera_rot = camera_base.get_node(@"CameraRot")
onready var spring_arm = get_node(@"SpringArm")
onready var camera = spring_arm.get_node(@"Camera")
onready var world = get_node("/root/World")

func _ready():
	if mouse_captured:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	animation_player = get_node("Model/AnimationPlayer")
	inventory = get_node("../InventoryStacked")
	br = inventory.get_item_by_id("branch")

func _process(delta):
	time += delta

	if Input.is_key_pressed(KEY_F) && hit == false and time > last_time_hit + 1 :
		#print(get_node(".").transform.origin.distance_to(get_node("/root/Spatial/tree/CollisionShape").transform.origin))
		#if get_node(".").transform.origin.distance_to(get_node("/root/Spatial/tree/CollisionShape").transform.origin)<0.2 :
		animation_player.play("ATK_AXE",-1,0.4,false)
		hit = true
		last_time_hit = time
		time_when_actionable = time + animation_player.get_current_animation_length()
		#else : hit = false
	else : hit = false

	if Input.is_action_just_pressed("toggle_build") and not is_placing:
		is_placing = true
		enter_building_mode()
	elif Input.is_action_just_pressed("toggle_build") and is_placing:
		is_placing = false
		exit_building_mode()

	if Input.is_action_just_pressed("cycle_building") and is_placing:
		cycle_building_type()

	if Input.is_action_just_pressed("place_building") and is_placing: # and self.branch > 0:
		var position = get_valid_building_position()
		if position != null:
			place_building(position)
			inventory.remove_item(br)
		else:
			print("No valid position")
	
	if is_placing:
		change_building_height()

func _physics_process(delta):
	
	#player movement XY
	var dir = Vector3(0, 0, 0)
	if can_move and (is_on_floor() or allow_fall_input) and is_actionable():
		
		#Left
		if Input.is_action_pressed("move_left"):
			dir.x += 1
			
		#Right
		if Input.is_action_pressed("move_right"):
			dir.x -= 1
			
		#Forward
		if Input.is_action_pressed("move_forward"):
			dir.z += 1;
			
		#Backwards	
		if Input.is_action_pressed("move_backwards"):
			dir.z -= 1
				
		if dir.length() != 0:
			animation_player.play("RUN")
		else:
			#if !animation_player.is_playing() :
			animation_player.play("IDLE")
		
		#Jump
		if Input.is_action_pressed("move_jump") and is_on_floor():
			velocity += jump_vector * Jump_speed - (jump_vector * -1).normalized() * velocity.dot(jump_vector * -1)
	
		#Sprint toggle
		if can_sprint and Input.is_action_just_pressed("move_sprint") and is_on_floor():
			move_sprint = true
			
		if can_sprint and not Input.is_action_pressed("move_sprint") and is_on_floor():
			move_sprint = false
	
	#Smooth movement
	dir = transform.basis.xform(dir.normalized()) * (move_speed_sprint if move_sprint else move_speed)
	if is_on_floor() or dir != Vector3(0, 0, 0):
		var acceleration = move_acceleration if dir.dot(velocity) else move_deacceleration
		var vp = gravaty_vector.normalized() * velocity.dot(gravaty_vector)
		velocity = (velocity - vp).linear_interpolate(dir, acceleration * delta) + vp
	

	#Gravaty
	if !is_on_floor():
		animation_player.play("IDLE_ITEM")
		velocity += gravaty_vector * gravaty * delta

	#Player move
	move_and_slide(velocity, floor_normal, stop_on_slope, max_slides, deg2rad(floor_max_angle), infinite_inertia)
	pass


func _input(event):
	#Mouse movement
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			var camera_speed_this_frame = CAMERA_MOUSE_ROTATION_SPEED
			rotate_camera(event.relative * camera_speed_this_frame)
	
func rotate_camera(move):
	# spring_arm.rotate_y(move.x)
	self.rotate_y(-move.x)
	# After relative transforms, camera needs to be renormalized.
	spring_arm.orthonormalize()
	camera_x_rot -= move.y
	camera_x_rot = clamp(camera_x_rot, deg2rad(CAMERA_X_ROT_MIN), deg2rad(CAMERA_X_ROT_MAX))
	spring_arm.rotation.x = camera_x_rot

func enter_building_mode():
	print("enter")
	placing_instance = building_type.instance()
	var building_offset = Vector3(0, 0, FORWARD_OFFSET)
	add_child(placing_instance)
	placing_instance.translate_object_local(building_offset)
	
func change_building_height():
	var height = camera_x_rot * HEIGHT_DELTA_SPEED
	var new_building_pos = Vector3(placing_instance.translation.x, height, placing_instance.translation.z)
	placing_instance.set_translation(new_building_pos)

func cycle_building_type():
	exit_building_mode()
	print("cycle")
	if building_index+1 == len(BUILDINGS):
		building_index = 0
	else:
		building_index += 1
	var building_uri = "res://objects/buildings/" + BUILDINGS[building_index] + ".tscn"
	building_type = load(building_uri)
	enter_building_mode()

func exit_building_mode():
	print("exit")
	placing_instance.queue_free()

func place_building(position):
	var building_instance = building_type.instance()
	world.add_child(building_instance)
	# building_instance.set_transform(self.get_global_transform())
	building_instance.translate(position[0])
	building_instance.set_rotation(position[1])
	building_instance.add_to_group(BUILDINGS[building_index])
	print("Name:", BUILDINGS[building_index])

func get_valid_building_position():
	match BUILDINGS[building_index]:
		"floor":
			print("place floor")
			return [placing_instance.get_global_translation(), placing_instance.get_global_rotation()]
		"wall":
			var bottom_edge = placing_instance.get_node("Bottom")
			var first_wall_corner = bottom_edge.get_node("Corner1")
			var second_wall_corner = bottom_edge.get_node("Corner2")
			
			var floors = get_tree().get_nodes_in_group("floor")
			for floor_ in floors:
				for socket_num in range(1, 3):
					var socket = floor_.get_node("LongEdge" + str(socket_num))
					var first_socket_corner = socket.get_node("Corner1")
					var second_socket_corner = socket.get_node("Corner2")
					if first_wall_corner.overlaps_area(first_socket_corner) and second_wall_corner.overlaps_area(second_socket_corner) or \
							second_wall_corner.overlaps_area(first_socket_corner) and first_wall_corner.overlaps_area(second_socket_corner):
						return [socket.get_global_translation(), socket.get_global_rotation()]
		"roof":
			for socket_num in range(1, 3):
				var roof_socket = placing_instance.get_node("LongEdge" + str(socket_num))
				var first_roof_socket_corner = roof_socket.get_node("Corner1")
				var second_roof_socket_corner = roof_socket.get_node("Corner2")

				var walls = get_tree().get_nodes_in_group("wall")
				for wall in walls:
					var wall_socket = wall.get_node("Top")
					var first_wall_socket_corner = wall_socket.get_node("Corner1")
					var second_wall_socket_corner = wall_socket.get_node("Corner2")
					if first_wall_socket_corner.overlaps_area(first_roof_socket_corner) and second_wall_socket_corner.overlaps_area(second_roof_socket_corner) or \
							second_wall_socket_corner.overlaps_area(first_roof_socket_corner) and first_wall_socket_corner.overlaps_area(second_roof_socket_corner):
						return [wall_socket.get_global_translation() + (wall_socket.get_global_rotation() * roof_socket.get_translation()), wall_socket.get_global_rotation()]
	return null

func is_actionable():
	if time > time_when_actionable and !is_inven_open:
		return true
	return false
