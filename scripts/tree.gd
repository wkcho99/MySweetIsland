extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var _animator := $AnimationPlayer
<<<<<<< HEAD
var fall = false
var can_cut = false
=======
onready var _particles := $Particles

>>>>>>> 61e9a940cdc51e64f4b99f587932b99f11d19cd4
# Called when the node enters the scene tree for the first time.
func _ready():
	var world = $World

func _process(delta):
	if get_node("./Area").overlaps_body(get_node("../Player/PlayerBody")) :
		can_cut = true
	else: can_cut = false
	#if get_node("./Area").overlaps_body(get_node("../Player/PlayerBody")) :
	#	can_cut = false
	_fall()

func _fall():
<<<<<<< HEAD
	if get_node("../Player/PlayerBody").hit && fall == false && can_cut: 
		_animator.play("fall")
		fall = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
=======
	if get_node("../Player/PlayerBody").hit : 
		_animator.play("fall")
		_particles.emitting = false


func _sparkle():
	pass
>>>>>>> 61e9a940cdc51e64f4b99f587932b99f11d19cd4
