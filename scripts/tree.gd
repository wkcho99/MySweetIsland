extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var _animator := $AnimationPlayer
var fall = false
var can_cut = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _process(delta):
	if get_node("./Area").overlaps_body(get_node("../Player/PlayerBody")) :
		can_cut = true
	else: can_cut = false
	#if get_node("./Area").overlaps_body(get_node("../Player/PlayerBody")) :
	#	can_cut = false
	_fall()

func _fall():
	if get_node("../Player/PlayerBody").hit && fall == false && can_cut: 
		_animator.play("fall")
		fall = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
