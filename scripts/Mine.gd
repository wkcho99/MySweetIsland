extends Spatial

onready var _animator := get_node("AnimationPlayer")
onready var world = get_node("/root/World")
onready var _particles = get_node("Particles")
onready var player = get_node("/root/World/Player")
var fall = false
var can_cut = false
var time_start = 0
var time_now = 0
var time_elapsed = time_now - time_start
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var prob = 0
var drop_table = {0.55: "stone", 0.05:"gold", 0.4: "soil"}
var dropped_item = null
var drop_rate = 0
var rnd
export (int) var FORWARD_OFFSET = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	rnd = RandomNumberGenerator.new()
	rnd.randomize()

	_particles.emitting = false
	add_to_group("mines")
	get_node(".").rotation.y = rand_range(0, 360)
	var horizontal_scale = rand_range(0.8, 1.5)
	get_node(".").scale.x = horizontal_scale
	get_node(".").scale.y = rand_range(0.8, 1.5)
	get_node(".").scale.z = horizontal_scale
	pass

func _process(delta):
	if get_node("Area").overlaps_body(player) :
		can_cut = true
	else: can_cut = false
		
	#if get_node("./Area").overlaps_body(get_node("../Player/PlayerBody")) :
	#	can_cut = false\
	
	_fall()
	_regen()

func _fall():
	if player.hit && fall == false && can_cut: 
		_animator.play("fall")
		time_start = OS.get_ticks_msec()
		fall = true
		print(world)
		world.has_mined = true
		_particles.emitting = false
	if get_node("Sphere").mesh.surface_get_material(0).albedo_color[3] > 0 and \
		 player.hit and can_cut:
		_drop()
	elif get_node("Sphere").mesh.surface_get_material(0).albedo_color[3] == 0 : 
		get_node("Area/CollisionShape").disabled = true
		get_node("StaticBody/CollisionShape").disabled = true
		
		
func _regen():
	time_now = OS.get_ticks_msec()
	time_elapsed = time_now - time_start
	if time_elapsed > 50000 && time_start != 0 :
		# print(str(time_elapsed))
		_animator.play("regen")
		fall = false
		can_cut = true
		get_node("Area/CollisionShape").disabled = false
		get_node("StaticBody/CollisionShape").disabled = false
	

func _drop():
	var chance = rnd.randf()
	print(str(chance))
	prob = 0
	for drop_rate in drop_table.keys():
		if prob<=chance and chance < prob+ drop_rate:
			dropped_item = drop_table[drop_rate]
		prob+= drop_rate
	print(dropped_item)
	var material_url = "res://objects/nature/" + dropped_item + ".tscn"
	var building_type = load(material_url)
	var placing_instance = building_type.instance()
	add_child(placing_instance)
	var pos = rnd.randi_range(3,5)
	placing_instance.translate(Vector3(pos,0,0))
