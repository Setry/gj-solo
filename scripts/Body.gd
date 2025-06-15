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
#	self.area_entered.connect(_on_area_entered)
	self.body_entered.connect(_on_body_entered)
	var sprites = ["res://Sprites/Planet1.png", "res://Sprites/Planet2.png", "res://Sprites/Planet3.png", "res://Sprites/Planet4.png"]
	$Sprite2D.texture = load(sprites[floor(randf() * len(sprites))])

func _on_body_entered(body: Node2D):
	if body.name != "Player":
		return
	
	if body._attach_to(self):
		var main = get_tree().root.get_node("Node2D")
		main.meteor_collided()

#func _on_area_entered(area: Node2D):
#	print("E")

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
		get_tree().root.get_node("Node2D").spawn_meteor()
	
