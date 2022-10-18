extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var _inventory = InventoryStacked
onready var _recipes = Inventory
onready var _ctrlrecipes = CtrlInventory
# Called when the node enters the scene tree for the first time.
func _ready():
	_inventory = get_node("../../InventoryStacked")
	_recipes = get_node("../../Inventory")
	_ctrlrecipes = get_node("../../CtrlInventory")
func _process(delta):
	pass
#	if pressed:
#		if _ctrlrecipes.is_craftable:
#			if _inventory.has_item(_ctrlrecipes.current_recipe) :
#				_inventory.add_item(_ctrlrecipes.current_recipe)
#			else :
#				_inventory.create_and_add_item(_ctrlrecipes.current_recipe.get_property("id"))
#
#		else :
#			print("can't craft!")
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
