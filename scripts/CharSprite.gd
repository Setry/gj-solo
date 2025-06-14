extends Sprite2D

const MOVEMENT_SPEED: float = 5
const ROTATION_SPEED: float = 0.1

var indicator: Sprite2D
var hue: float = 0
var velocity: Vector2 = Vector2()
var angle: float = 0

func _ready() -> void:
	self.indicator = get_parent().get_node("Indicator") as Sprite2D

func _process(delta):
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
	self.angle += 0.1
	self.angle = fmod(self.angle, 6.28)
	self.indicator.position = self.position + Vector2(cos(angle), sin(angle)).normalized() * 20
	self.indicator.rotation = angle

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("press"):
		velocity = Vector2(cos(angle), sin(angle)).normalized() * MOVEMENT_SPEED
