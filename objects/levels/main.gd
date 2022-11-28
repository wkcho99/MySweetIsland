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
var tree_tutorial = true
var build_tutorial = true
var inven_tutorial = true
var craft_tutorial = true

func _ready() -> void:
	get_node("CanvasLayer2/tree").visible = false
	get_node("CanvasLayer2/build").visible = false
	get_node("CanvasLayer2/inven").visible = false
	get_node("CanvasLayer2/craft").visible = false
	get_node("CanvasLayer").visible = false
	_recipes.hide()
	_inventory.hide()
	inventoryManager = get_node("InventoryStacked")
	inventoryManager.remove_all_items()
func _process(delta):
	if tree_tutorial and get_node("Player").translation.distance_to(get_node("tree").translation)<5:
		print(get_node("Player").translation.distance_to(get_node("tree").translation))
		tree_tutorial()
	if inven_tutorial and get_node("InventoryStacked").get_item_by_id("branch") != null and get_node("InventoryStacked").has_item(get_node("InventoryStacked").get_item_by_id("branch")):
		inven_tutorial()
	if build_tutorial and get_node("InventoryStacked").get_item_by_id("wall") != null and get_node("InventoryStacked").has_item(get_node("InventoryStacked").get_item_by_id("wall")):
		build_tutorial()
	if Input.is_action_just_pressed("open_inventory"):
		if _inventory.visible:
			_inventory.hide()
			#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			_inventory.show()
			get_node("CanvasLayer2/inven").visible = false
			inven_tutorial = false
			if craft_tutorial:
				craft_tutorial()
			#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	if Input.is_action_just_pressed("open_recipes"):		
		if _recipes.visible:
			_recipes.hide()
			get_node("CanvasLayer").visible = false
			#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			_recipes.show()
			get_node("CanvasLayer2/craft").visible = false
			craft_tutorial = false
			
			#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	if _inventory.visible or _recipes.visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		get_node("Player").is_inven_open = true
	else :
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		$Player.is_inven_open = false
	
	if Input.is_action_just_pressed("save"):
		save_game()

func save_game():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.filename.empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save")

		# Store the save dictionary as a new line in the save file.
		save_game.store_line(to_json(node_data))
	save_game.close()
	
func tree_tutorial():
	get_node("CanvasLayer2/tree").visible = true
	tree_tutorial = false
func inven_tutorial():
	get_node("CanvasLayer2/inven").visible = true
	inven_tutorial = false
func craft_tutorial():
	get_node("CanvasLayer2/craft").visible = true
func build_tutorial():
	get_node("CanvasLayer2/build").visible = true
	build_tutorial = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
