extends Path


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var _curve = Curve3D.new()
	set_curve(_curve)
	_curve.add_point($PathFollow/RigidBody.transform.origin)
#	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(1,0,0))
#	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(3,0,0))
#	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(5,0,0))
#	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(5,0,1))
#	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(5,0,3))
#	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(5,0,5))
#	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(3,0,5))
#	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(1,0,5))
#	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(0,0,3))
#	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(0,0,1))
#	_curve.add_point($PathFollow/RigidBody.transform.origin)
#	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(1,0,0))
	$PathFollow/RigidBody.look_at($PathFollow/RigidBody.global_transform.origin, Vector3.UP)
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(1,0,1))
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(3,0,3))
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(3,0,5))
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(1,0,7))
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(0,0,9))
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(-2,0,7))
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(-4,0,5))
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(-4,0,3))
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(-2,0,1))
	_curve.add_point($PathFollow/RigidBody.transform.origin)
	_curve.add_point($PathFollow/RigidBody.transform.origin+Vector3(1,0,1))
	pass # Replace with function body.
func _physics_process(delta):
	
	var old_pos = $PathFollow/RigidBody.global_translation
	$PathFollow/RigidBody/scene/AnimationPlayer.play("run")
	get_node("PathFollow").offset += delta * 2
	var direction = $PathFollow/RigidBody.global_translation- old_pos
	$PathFollow/RigidBody.look_at($PathFollow/RigidBody.global_transform.origin, Vector3.UP)
#	print($PathFollow/RigidBody.global_translation)
#	$PathFollow/RigidBody.look_at_from_position($PathFollow/RigidBody.global_translation, _curve.get_closest_point($PathFollow/RigidBody.global_translation), Vector3.UP)
#	$PathFollow/RigidBody.look_at(_curve.get_closest_point($PathFollow/RigidBody.global_translation), Vector3.UP)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
