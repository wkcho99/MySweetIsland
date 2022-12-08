extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var settings_menu = $SettingsMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/StartButton.grab_focus()
	pass # Replace with function body.

func _on_StartButton_pressed():
	visible = false
	get_tree().change_scene("res://objects/levels/main.tscn")
#func _on_LoadButton_pressed():
#	var save_game = File.new()
#	if not save_game.file_exists("user://savegame.save"):
#		return # Error! We don't have a save to load.
#
#	# We need to revert the game state so we're not cloning objects
#	# during loading. This will vary wildly depending on the needs of a
#	# project, so take care with this step.
#	# For our example, we will accomplish this by deleting saveable objects.
#	var save_nodes = get_tree().get_nodes_in_group("Persist")
#	for i in save_nodes:
#		i.queue_free()
#
#	# Load the file line by line and process that dictionary to restore
#	# the object it represents.
#	save_game.open("user://savegame.save", File.READ)
#	while save_game.get_position() < save_game.get_len():
#		# Get the saved dictionary from the next line in the save file
#		var node_data = parse_json(save_game.get_line())
#
#		# Firstly, we need to create the object and add it to the tree and set its position.
#		var new_object = load(node_data["filename"]).instance()
#		get_node(node_data["parent"]).add_child(new_object)
#		new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])
#
#		# Now we set the remaining variables.
#		for i in node_data.keys():
#			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
#				continue
#			new_object.set(i, node_data[i])
#
#	save_game.close()
func _on_ExitButton_pressed():
	get_tree().quit()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_OptionButton_pressed():
	settings_menu.popup_centered()
#	var options = load("res://objects/levels/settings_menu.tscn").instance()
#	get_tree().current_scene.add_child(options)
	pass # Replace with function body.
