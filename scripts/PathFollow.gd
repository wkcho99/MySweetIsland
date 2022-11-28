extends PathFollow


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var _curve = Curve3D.new()
	get_node("../").set_curve(_curve)
	_curve.add_point(Vector3(0,0,0))
	_curve.add_point(Vector3(1,0,0))
	_curve.add_point(Vector3(1,0,1))
	_curve.add_point(Vector3(3,0,1))
	_curve.add_point(Vector3(5,0,1))
	_curve.add_point(Vector3(7,0,1))
	_curve.add_point(Vector3(9,0,1))
	_curve.add_point(Vector3(11,0,1))
	self.offset += delta * 10	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
