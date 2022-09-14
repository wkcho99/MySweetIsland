extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var hitt = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _process(delta):
	_hit()
func _hit():
	if Input.is_action_pressed("ui_accept"):
		hitt = true
	else : hitt = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
