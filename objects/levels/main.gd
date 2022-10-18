extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (bool) var first_tree_cut = false

# Called when the node enters the scene tree for the first time.
var inventoryManager

export(bool) var clear_inventory = true

onready var _inventory = $CtrlInventoryStacked
onready var _recipes = $CtrlInventory

func _ready() -> void:
	
	get_node("CanvasLayer").visible = false
	_recipes.hide()
	_inventory.hide()
func _process(delta):
	if Input.is_action_just_pressed("open_inventory"):
		if _inventory.visible:
			_inventory.hide()
			#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			_inventory.show()
			#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	if Input.is_action_just_pressed("open_recipes"):		
		if _recipes.visible:
			_recipes.hide()
			get_node("CanvasLayer").visible = false
			#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			_recipes.show()
			#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	if _inventory.visible or _recipes.visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		get_node("Player").is_inven_open = true
	else :
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		$Player.is_inven_open = false




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
