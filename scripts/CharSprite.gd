extends Sprite2D

var hue: float = 0

var indicator: Sprite2D
var paused: bool = false

func _ready() -> void:
	self.indicator = get_parent().get_node("Indicator") as Sprite2D

func _process(delta):
	if not paused:
		hue += 0.005
	self.modulate = Color.from_hsv(hue, 1, 1, 1)
