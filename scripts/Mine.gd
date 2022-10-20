extends Spatial

onready var _animator := get_node("AnimationPlayer")
var fall = false
var can_cut = false
onready var _particles := $Particles
var time_start = 0
var time_now = 0
var time_elapsed = time_now - time_start
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var drop_table = {0.6: "stone", 0.01:"gold", 0.39: "soil"}

# Called when the node enters the scene tree for the first time.
func _ready():
#	var chance = RandomNumberGenerator().randfn()
#	for drop_rate in drop_table.keys().sort():
#		if chance < drop_rate:
#			dropped_item = drop_table[drop_rate]
#	var building_uri = "res://objects/nature/" + dropped_item + ".tscn"
#	building_type = load(building_uri)
	pass # Replace with function body.

func _process(delta):
	if get_node("Area").overlaps_body(get_node("../Player")) :
		can_cut = true
	else: can_cut = false
		
	#if get_node("./Area").overlaps_body(get_node("../Player/PlayerBody")) :
	#	can_cut = false\
	
	_fall()
	_regen()

func _fall():
	if get_node("../Player").hit && fall == false && can_cut: 
		_animator.play("fall")
		time_start = OS.get_ticks_msec()
		fall = true
	if get_node("Sphere").mesh.surface_get_material(0).albedo_color[3] > 0 and \
		 get_node("../Player").hit and can_cut:
		print("material")
#	elif get_node("Sphere").mesh.surface_get_material(0).albedo_color[3] == 0 : 
#		time_start = OS.get_ticks_msec()
		
		
func _regen():
	time_now = OS.get_ticks_msec()
	time_elapsed = time_now - time_start
	# print(str(time_elapsed))
	if time_elapsed > 10000 && time_start != 0 :
		# print("regen")
#		_animator.play("regen")
		fall = false
		can_cut = true

