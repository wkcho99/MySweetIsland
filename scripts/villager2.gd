extends KinematicBody

# Minimum speed of the mob in meters per second.
export var min_speed = 0.1

# Maximum speed of the mob in meters per second.
export var max_speed = 0.15
var velocity = Vector3.ZERO
var can_talk = false
var talking = false
onready var player = get_node("/root/World/Player")
func _ready():
	DialogueManager.connect("dialogue_started", self, "_talking")
	DialogueManager.connect("dialogue_finished", self, "_finishtalk")
	pass
func _process(delta):
	if Input.is_action_just_pressed("talk"):
		_fall()
	else: 
		can_talk = false
	#if get_node("./Area").overlaps_body(get_node("../Player/PlayerBody")) :
	#	can_cut = false
	

func _fall():
	if get_node("Area").overlaps_body(player)&& talking == false:
		print("talk")
		var resource = load("res://deku.tres")
		DialogueManager.show_example_dialogue_balloon("deku",resource)
		talking = true
func _finishtalk():
	talking= false
func _talking():
	talking= true
