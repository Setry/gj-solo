extends Area2D


func _ready() -> void:
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D):
	if body.name != "Player":
		return
	
	if body.attached_to != null:
		return
	
	print("Collected star")
	var main = get_tree().root.get_node("Node2D");
	main.star_collected()
	queue_free()
	main.spawn_star()

func _get_color():
	return $Sprite2D.modulate

func _physics_process(delta: float) -> void:
	var cam = get_tree().root.get_node("Node2D/Camera2D") as Camera2D
	var main = get_tree().root.get_node("Node2D");
	var vp = get_viewport_rect().size
	if abs(position.y - (cam.position.y + vp.x / 2)) > vp.x / 2 * 2:
		queue_free()
		main.spawn_star()
