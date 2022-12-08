extends Path


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var max_speed = 5.0
#var min_speed = 1.5
# Called when the node enters the scene tree for the first time.
onready var villager = $PathFollow/RigidBody
onready var player = get_node("/root/World/Player")
func _ready():
	var _curve = Curve3D.new()
	set_curve(_curve)
	_curve.add_point($PathFollow/RigidBody.transform.origin)
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(1,0,1))
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(3,0,3))
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(5,0,5))
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(5,0,7))
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(3,0,9))
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(1,0,11))
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(-1,0,9))
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(-3,0,7))
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(-5,0,5))
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(-7,0,3))
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(-9,0,3))
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(-7,0,1))
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(-5,0,0))
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(-3,0,0))
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(-1,0,0))
	_curve.add_point($PathFollow/RigidBody.transform.origin)
#	_curve.add_point($PathFollow/RigidBody.transform.origin)
#	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(1,0,1))
	pass # Replace with function body.
func _physics_process(delta):
	
	var old_pos = villager.global_transform.origin
	if villager.talking :
		player.can_move = false
		
		$PathFollow/RigidBody/scene/AnimationPlayer.play("idle")
		villager.look_at(player.global_translation, Vector3.UP)
		villager.rotate(Vector3.UP, PI)
#	var random_speed = rand_range(min_speed, max_speed)
	else:
		player.can_move = true
		$PathFollow/RigidBody/scene/AnimationPlayer.play("run")
		get_node("PathFollow").offset += delta * 3
		var direction = villager.global_transform.origin- old_pos
		villager.look_at(villager.global_transform.origin-direction, Vector3.UP)
#	print($PathFollow/RigidBody.global_translation)
#	$PathFollow/RigidBody.look_at_from_position($PathFollow/RigidBody.global_translation, _curve.get_closest_point($PathFollow/RigidBody.global_translation), Vector3.UP)
#	$PathFollow/RigidBody.look_at(_curve.get_closest_point($PathFollow/RigidBody.global_translation), Vector3.UP)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
