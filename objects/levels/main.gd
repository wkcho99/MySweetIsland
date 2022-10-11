extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (bool) var first_tree_cut = false

# Called when the node enters the scene tree for the first time.
var inventoryManager

export(bool) var clear_inventory = true

onready var _inventory = $CtrlInventoryStacked

func _ready() -> void:
	if get_tree().get_root().has_node("InventoryManager"):
		inventoryManager = get_tree().get_root().get_node("InventoryManager")
		inventoryManager.player = $Player
		if clear_inventory:
			inventoryManager.clear_inventory(_inventory.inventory)
func _process(delta):
	if Input.is_action_just_pressed("open_inventory"):
		if _inventory.visible:
			_inventory.hide()
		else:
			_inventory.show()





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
