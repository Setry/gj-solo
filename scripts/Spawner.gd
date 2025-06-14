extends Node2D

var bodyScene

func _ready() -> void:
	bodyScene = load("res://assets/Body.tscn")
	for i in 10:
		_spawn()

func _process(delta: float) -> void:
	var counter = 0
	for c in get_children():
		# Dumb check to see if obj is meteorite
		if c.has_method("_on_body_entered") and c.has_method("_get_color") and c._get_color() != Color(1, 1, 1):
			counter += 1
	
	#$UI/Control/Counter.text = str(counter)

func _spawn():
	var cam = get_tree().root.get_node("Node2D/Camera2D") as Camera2D
	var rect = get_viewport_rect().size
	var newBody = bodyScene.instantiate() 
	newBody.position = Vector2(rect.x * randf() + cam.position.x, rect.y * randf() + cam.position.y)
	add_child(newBody)
