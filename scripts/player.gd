extends CharacterBody2D

var pos : Vector2;
var old_pos : Vector2;
var moving : bool;
var rotation_speed = 1.5 

func _ready():
	old_pos = global_position;
	pos = global_position;

func _physics_process(delta):
	self.rotate(rotation_speed)
	
