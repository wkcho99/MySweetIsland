extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

var viewportWidth = get_viewport().size.x
var viewportHeight = get_viewport().size.y

func _ready():
# Optional: Center the sprite, required only if the sprite's Offset>Centered checkbox is set
	self.set_position(Vector2(viewportWidth/2, viewportHeight/2))
	var scale = viewportWidth / self.texture.get_size().x
# Set same scale value horizontally/vertically to maintain aspect ratio
# If however you don't want to maintain aspect ratio, simply set different
# scale along x and y
	self.set_scale(Vector2(scale, scale))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
