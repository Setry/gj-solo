extends Area2D

var velocity: Vector2
var min_velocity: float = 2
var max_velocity: float = 5
var border_size: float = 20

func _init() -> void:
	var mult = (randf() * (max_velocity - min_velocity)) + min_velocity
	var angle = randf() * PI * 2
	self.velocity = Vector2.from_angle(angle) * mult
	self.rotation = randf() * PI * 2

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)
	var sprites = ["res://Sprites/Enemy.png", "res://Sprites/Enemy2.png"]
	$Sprite2D.texture = load(sprites[floor(randf() * len(sprites))])

func _on_body_entered(body: Node2D):
	if body.name != "Player":
		return
	
	if body.attached_to != null:
		return
	
	var main = get_tree().root.get_node("Node2D")
	main.enemy_collided()
	queue_free()
	get_tree().root.get_node("Node2D").spawn_enemy()

func _set_color(color: Color):
	$Sprite2D.modulate = color

func _get_color():
	return $Sprite2D.modulate

func _physics_process(delta: float) -> void:
	position += velocity
	
	var cam = get_tree().root.get_node("Node2D/Camera2D") as Camera2D
	var vp = get_viewport_rect().size
	# TODO: maybe detach player on both these conditions
	if position.x > cam.position.x + vp.x + border_size:
		position.x = cam.position.x - border_size
	if position.x < cam.position.x - border_size:
		position.x = cam.position.x + vp.x + border_size
		
	if position.y > cam.position.y + vp.y + border_size or position.y < cam.position.y - border_size:
		queue_free()
		get_tree().root.get_node("Node2D").spawn_enemy()
	
