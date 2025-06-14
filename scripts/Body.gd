extends Area2D

var velocity: Vector2
var min_velocity: float = 2
var max_velocity: float = 5
var border_size: float = 20

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)
	var mult = (randf() * max_velocity - min_velocity) + min_velocity
	self.velocity = Vector2(randf(), randf()).normalized() * mult

func _on_body_entered(body: Node2D):
	$Sprite2D.modulate = body._get_color()
	body._attach_to(self)

func _get_color():
	return $Sprite2D.modulate

func _physics_process(delta: float) -> void:
	position += velocity
	
	var cam = get_tree().root.get_node("Node2D/Camera2D") as Camera2D
	var vp = get_viewport_rect().size + cam.position
	if position.x > vp.x + border_size:
		position.x = -border_size
	if position.x < -border_size:
		position.x = vp.x + border_size
		
	if position.y > vp.y + border_size or position.y < -border_size:
		queue_free()
		get_tree().root.get_node("Node2D")._spawn()
	
