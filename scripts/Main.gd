extends Node2D

var bodyScene
var enemyScene
var starScene
var border_radius: float = 20
var score: int
var planet_duration: float
var hp: float = 100
var timer: float = 0

func _ready() -> void:
	bodyScene = load("res://assets/Body.tscn")
	for i in 10:
		spawn_meteor()

	enemyScene = load("res://assets/Enemy.tscn")
	for i in 2:
		spawn_enemy()

	starScene = load("res://assets/Star.tscn")
	for i in 5:
		spawn_star()
	
	_update_score()

func _process(delta: float) -> void:
	var counter = 0
	for c in get_children():
		# Dumb check to see if obj is meteorite
		if c.has_method("_on_body_entered") and c.has_method("_get_color") and c._get_color() != Color(1, 1, 1):
			counter += 1
	
	#$UI/Control/Counter.text = str(counter)

func spawn_meteor():
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
	$Spawner.add_child(newBody)
	
func spawn_enemy():
	var cam = get_tree().root.get_node("Node2D/Camera2D") as Camera2D
	var vp = get_viewport_rect().size
	var newBody = enemyScene.instantiate() 
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
	$Spawner.add_child(newBody)

func spawn_star():
	var cam = get_tree().root.get_node("Node2D/Camera2D") as Camera2D
	var vp = get_viewport_rect().size
	var newStar = starScene.instantiate() 
	var spawnX = cam.position.x + vp.x * randf()
	var spawnY = cam.position.y - border_radius - vp.y * randf()
	newStar.position = Vector2(spawnX, spawnY)
	$Spawner.add_child(newStar)

func star_collected():
	score += 1
	if score >= 10:
		var win = find_child("WinContainer") as VBoxContainer
		win.visible = true
		get_tree().paused = true
	
	_update_score()

func meteor_collided():
	#_update_score()
	pass

func enemy_collided():
	hp -= 20
	if hp <= 0:
		var lose = find_child("LoseContainer") as VBoxContainer
		lose.visible = true
		get_tree().paused = true
		
	_update_score()

func add_planet_duration(delta: float):
	planet_duration += delta
	_update_score()

func add_hp(hp: float):
	self.hp += hp
	self.hp = min(100, self.hp)
	_update_score()

func _physics_process(delta: float) -> void:
	self.timer += delta
	_update_score()

func _update_score():
	var counter = self.find_child("Counter", true, false)
	counter.text = str(score)
	
	var planet_duration_counter = self.find_child("PlanetDurationCounter", true, false)
	planet_duration_counter.text = str(round(planet_duration * 1000) / 1000)
	
	var hp_indicator = self.find_child("HP", true, false)
	hp_indicator.text = str(round(hp))
	
	var timer = self.find_child("Timer", true, false)
	timer.text = str(round(self.timer * 1000) / 1000)
