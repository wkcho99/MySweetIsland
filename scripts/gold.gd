extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
onready var inventory: InventoryStacked
var br : InventoryItem

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory = get_node("/root/World/InventoryStacked")
	br = inventory.get_item_by_id("gold")
	set_axis_lock(1, true)
	set_axis_lock(2, true)
	set_axis_lock(4, true)
	set_axis_lock(8, true)
	set_axis_lock(16, true)
	set_axis_lock(32, true)
	pass # Replace with function body.

func _process(delta):
#	pass
#	print(get_node("../"))
	if get_node("../").fall == true :
		set_axis_lock(1, false)
		set_axis_lock(2, false)
		set_axis_lock(4, false)
		visible = true
		#add_force(Vector3(-10,-10,-10),Vector3(-10,-10,-10))

	if get_node("./Area").overlaps_body(get_node("/root/World/Player"))  && visible == true:
		visible = false
		queue_free()
		if inventory.get_item_by_id("gold") != null and inventory.has_item(inventory.get_item_by_id("gold")):
			br = inventory.get_item_by_id("gold")
			inventory.add_item(br)
		else :
			print("in else")
			inventory.create_and_add_item("gold")
			br = inventory.get_item_by_id("gold")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
