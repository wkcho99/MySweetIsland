extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var _animator := $AnimationPlayer
onready var _particles := $Particles

# Called when the node enters the scene tree for the first time.
func _ready():
	var world = $World

func _process(delta):
	_fall()

func _fall():
	if get_node("../Player/PlayerBody").hit : 
		_animator.play("fall")
		_particles.emitting = false


func _sparkle():
	pass
