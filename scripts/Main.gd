extends Node2D

var bodyScene
var starScene
var border_radius: float = 20
var score: int

func _ready() -> void:
	bodyScene = load("res://assets/Body.tscn")
	for i in 10:
		_spawn()

	starScene = load("res://assets/Star.tscn")
	for i in 10:
		_spawn_star()

func _process(delta: float) -> void:
	var counter = 0
	for c in get_children():
		# Dumb check to see if obj is meteorite
		if c.has_method("_on_body_entered") and c.has_method("_get_color") and c._get_color() != Color(1, 1, 1):
			counter += 1
	
	#$UI/Control/Counter.text = str(counter)

func _spawn():
	var cam = get_tree().root.get_node("Node2D/Camera2D") as Camera2D
	var vp = get_viewport_rect().size
	var newBody = bodyScene.instantiate() 
	#newBody.position = Vector2(vp.x * randf() + cam.position.x, vp.y * randf() + cam.position.y)
	#print(newBody.velocity)
	var spawnRadius = sqrt(get_viewport_rect().size.x * get_viewport_rect().size.x + get_viewport_rect().size.y * get_viewport_rect().size.y)
	var minX = cam.position.x - border_radius
	var minY = cam.position.y - border_radius
	var maxX = cam.position.x + vp.x + border_radius
	var maxY = cam.position.y + vp.y + border_radius
	var pos = cam.position + vp / 2 - newBody.velocity.normalized() * spawnRadius
	pos = Vector2(clampf(pos.x, minX, maxX), clampf(pos.y, minY, maxY))
	newBody.position = pos
	add_child(newBody)

func _spawn_star():
	var cam = get_tree().root.get_node("Node2D/Camera2D") as Camera2D
	var vp = get_viewport_rect().size
	var newStar = starScene.instantiate() 
	var spawnX = cam.position.x + vp.x * randf()
	var spawnY = cam.position.y - border_radius - vp.y * randf()
	newStar.position = Vector2(spawnX, spawnY)
	add_child(newStar)

func star_collected():
	score += 10
	_update_score()

func meteor_collided():
	score -= 1
	_update_score()

func _update_score():
	var counter = self.find_child("Counter", true, false)
	counter.text = str(score)
