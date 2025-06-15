extends Area2D


func _ready() -> void:
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D):
	print("Collected star")
	var main = get_tree().root.get_node("Node2D");
	main.star_collected()
	queue_free()

func _get_color():
	return $Sprite2D.modulate
