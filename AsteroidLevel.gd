extends Node2D

var Asteroid = preload("res://Asteroid.tscn")

func _ready():
	randomize()

func spawn_asteroid():
	var asteroid_position = Vector2(rand_range(0, 1054), -50)
	var asteroid = Asteroid.instance()
	asteroid.position = asteroid_position
	add_child(asteroid)

func _on_Timer_timeout():
	spawn_asteroid()
