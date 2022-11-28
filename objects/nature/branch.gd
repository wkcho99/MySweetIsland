extends RigidBody
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var inventory: InventoryStacked
onready var player = get_node("/root/World/Player")
var br : InventoryItem
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	print(get_node("../"))
	set_axis_lock(1, true)
	set_axis_lock(2, true)
	set_axis_lock(4, true)
	set_axis_lock(8, true)
	set_axis_lock(16, true)
	set_axis_lock(32, true)
	print(get_tree().get_root())
	inventory = get_node("/root/World/InventoryStacked") # get_node("../../InventoryStacked")
	br = inventory.get_item_by_id("branch")
	inventory.remove_all_items()
	pass # Replace with function body.

func _process(delta):
	if get_node("../").fall == true :
		visible = true
		set_axis_lock(1, false)
		set_axis_lock(2, false)
		set_axis_lock(4, false)
		#add_force(Vector3(-10,-10,-10),Vector3(-10,-10,-10))
		
	if get_node("./Area").overlaps_body(player) && get_node("../").fall == true :
		get_node("../").fall = false
		visible = false
		if inventory.get_item_by_id("branch") != null and inventory.has_item(inventory.get_item_by_id("branch")):
			br = inventory.get_item_by_id("branch")
			inventory.add_item(br)
		else :
			print("in else")
			inventory.create_and_add_item("branch")
			br = inventory.get_item_by_id("branch")
		print(inventory.get_item_count())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
