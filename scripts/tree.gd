extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var _animator := get_node("RootNode/AnimationPlayer")
var fall = false
var can_cut = false
onready var _particles := $Particles
var time_start = 0
var time_now = 0
var time_elapsed = time_now - time_start
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	if get_node("./RootNode/Area").overlaps_body(get_node("../Player")) :
		can_cut = true
	else: can_cut = false
	#if get_node("./Area").overlaps_body(get_node("../Player/PlayerBody")) :
	#	can_cut = false
	_fall()
	_regen()

func _fall():
	if get_node("../Player").hit && fall == false && can_cut: 
		_animator.play("fall")
		fall = true
		_particles.emitting = false
		time_start = OS.get_ticks_msec()

func _regen():
	time_now = OS.get_ticks_msec()
	time_elapsed = time_now - time_start
	if time_elapsed > 5000 && time_start != 0 :
		_animator.play("regen")
		fall = false
		can_cut = true
	


func _sparkle():
	pass
