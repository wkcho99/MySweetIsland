extends Spatial

# Called when the node enters the scene tree for the first time.
var inventoryManager
export(bool) var clear_inventory = true
onready var _inventory = $CtrlInventoryStacked
onready var _recipes = $CtrlInventory
onready var player = $Player

var prev_tree = null
var prev_mine = null
var has_mined = false
var has_cut_tree = false

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

	if not has_cut_tree:
		var trees = get_tree().get_nodes_in_group("trees")
		var closest_tree = null
		var min_distance = INF
		var dist_to_tree = null
		for tree in trees:
			dist_to_tree = sqrt(pow(player.translation.x - tree.translation.x, 2) + \
													pow(player.translation.y - tree.translation.y, 2) + \
													pow(player.translation.z - tree.translation.z, 2))
			if dist_to_tree < min_distance:
				closest_tree = tree
				min_distance = dist_to_tree
		if closest_tree != null:
			if prev_tree != null:
				prev_tree.get_node("Particles").emitting = false
			prev_tree = closest_tree	
			closest_tree.get_node("Particles").emitting = true

	if not has_mined:
		var mines = get_tree().get_nodes_in_group("mines")
		var closest_mine= null
		var min_distance = INF
		var dist_to_mine = null
		for mine in mines:
			dist_to_mine = sqrt(pow(player.translation.x - mine.translation.x, 2) + \
													pow(player.translation.y - mine.translation.y, 2) + \
													pow(player.translation.z - mine.translation.z, 2))
			if dist_to_mine < min_distance:
				closest_mine = mine
				min_distance = dist_to_mine
		if closest_mine != null:
			if prev_mine != null:
				prev_mine.get_node("Particles").emitting = false
			prev_mine = closest_mine	
			closest_mine.get_node("Particles").emitting = true




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
