extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var inventory: InventoryStacked
var br : InventoryItem

# Called when the node enters the scene tree for the first time.
func _ready():
#	inventory = get_node("../InventoryStacked")
#	br = inventory.get_item_by_id("stone")
	pass # Replace with function body.

func _process(delta):
	pass
#	if get_node("../Mine").fall == true :
#		visible = true
#		#add_force(Vector3(-10,-10,-10),Vector3(-10,-10,-10))
#
#	if get_node("./Area").overlaps_body(get_node("../Player")) && get_node("../Mine").fall == true :
#		get_node("../Mine").fall = false
#		visible = false
#		if inventory.get_item_by_id("stone") != null and inventory.has_item(inventory.get_item_by_id("branch")):
#			br = inventory.get_item_by_id("stone")
#			inventory.add_item(br)
#		else :
#			print("in else")
#			inventory.create_and_add_item("stone")
#			br = inventory.get_item_by_id("stone")
#		print(inventory.get_item_count())
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
