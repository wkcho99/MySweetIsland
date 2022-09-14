extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var _animator := $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _process(delta):
	_fall()
func _fall():
	if get_node("../Player").hitt : _animator.play("fall")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
