extends CharacterBody2D

var pos : Vector2;
var old_pos : Vector2;
var moving : bool;
var rotation_speed = 0.1
var movement_speed = 250
var attached_to: Node2D
var attach_offset: Vector2
var border_size: float = 20
var scroll_size: float = 20

func _ready():
	old_pos = global_position;
	pos = global_position;

func _attach_to(other):
	if attached_to != null:
		return false
	
	other._set_color(_get_color())
	attached_to = other
	attach_offset = position - other.position
	$Sprite2D.paused = true
	return true

func _get_color():
	return $Sprite2D.modulate

func _physics_process(delta):
	self.rotate(rotation_speed)
	move_and_slide()
		
	if attached_to != null:
		self.position = attached_to.position + attach_offset
		attach_offset *= 0.975
		var main = get_tree().root.get_node("Node2D")
		main.add_planet_duration(delta)
		main.add_fuel(delta * 5)
	
	var cam = get_tree().root.get_node("Node2D/Camera2D") as Camera2D
	var vp = get_viewport_rect().size
	if position.x > cam.position.x + vp.x + border_size:
		position.x = cam.position.x - border_size
	if position.x < cam.position.x - border_size:
		position.x = cam.position.x + vp.x + border_size
	
	cam.position.y = position.y - get_viewport_rect().size.y / 2

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("press"):
		var main = get_tree().root.get_node("Node2D")
		$JumpEmission.emitting = true
		main.jumped()
		
		if attached_to != null:
			# Detach from node
			attached_to = null
			attach_offset = Vector2()
			$Sprite2D.paused = false
		
		var actual_rotation = rotation - PI / 2 # 0 = up
		velocity = Vector2(cos(actual_rotation), sin(actual_rotation)).normalized() * movement_speed
