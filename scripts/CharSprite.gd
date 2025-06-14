extends Sprite2D

var hue: float = 0
var pressed: bool = false
var velocity: Vector2 = Vector2()

func _process(delta):
	if pressed:
		hue += 0.005
	self.modulate = Color.from_hsv(hue, 1, 1, 1)
	self.position += velocity
	#self.modulate = Color(0, 0, 1)
	#self.modulate = Color(1, 1, 1)
	
	
#func _input(event: InputEvent) -> void:
#	if event.is_action_pressed("press"):
#		velocity = Vector2(randf() - 0.5, randf() - 0.5).normalized()
#		print("test")
#		pressed = true
#	elif event.is_action_released("press"):
#		pressed = false
