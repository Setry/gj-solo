extends CharacterBody2D

var rotation_speed = 1.5 

func _process(delta):
	self.rotate(rotation_speed)
	
