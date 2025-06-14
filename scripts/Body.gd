extends Area2D

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)
	#self.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D):
	$Sprite2D.modulate = body._get_color()
	body._attach_to(self)
