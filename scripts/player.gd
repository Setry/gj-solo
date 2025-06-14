extends CharacterBody2D

var pos : Vector2;
var old_pos : Vector2;
var moving : bool;
var rotation_speed = 0.1
var movement_speed = 200
var attached_to: Node2D
var attach_offset: Vector2

func _ready():
	old_pos = global_position;
	pos = global_position;

func _attach_to(other):
	attached_to = other
	attach_offset = position - other.position
	$Sprite2D.paused = true

func _get_color():
	return $Sprite2D.modulate

func _physics_process(delta):
	self.rotate(rotation_speed)
	move_and_slide()
		
	if attached_to != null:
		self.position = attached_to.position + attach_offset
		attach_offset *= 0.975

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("press"):
		if attached_to != null:
			# Detach from node
			attached_to = null
			attach_offset = Vector2()
			$Sprite2D.paused = false
		
		var actual_rotation = rotation - PI / 2 # 0 = up
		velocity = Vector2(cos(actual_rotation), sin(actual_rotation)).normalized() * movement_speed
		print(velocity)
