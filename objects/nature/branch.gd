extends RigidBody
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	print("ready")
	set_axis_lock(1, true)
	set_axis_lock(2, true)
	set_axis_lock(4, true)
	set_axis_lock(8, true)
	set_axis_lock(16, true)
	set_axis_lock(32, true)
	pass # Replace with function body.

func _process(delta):
	if get_node("../tree").fall == true :
		visible = true
		set_axis_lock(1, false)
		set_axis_lock(2, false)
		set_axis_lock(4, false)
		#add_force(Vector3(-10,-10,-10),Vector3(-10,-10,-10))
		
	if get_node("./Area").overlaps_body(get_node("../Player/PlayerBody")) && visible == true :
		get_node("../tree").fall = false
		visible = false
		get_node("../Player/PlayerBody").branch += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
