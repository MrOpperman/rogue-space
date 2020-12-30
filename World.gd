extends Node2D

var enemy_1 = preload("res://Enemy.tscn")
var boss_1 = preload("res://Boss.tscn")
var Asteroid = preload("res://Asteroid.tscn")
var Asteroid2 = preload("res://Asteroid2.tscn")
var Spinny = preload("res://Spinny.tscn")

onready var WaveLabel = $CanvasLayer/WaveLabel
onready var Score = $CanvasLayer/Score

var stats = PlayerStats
var spawnCounter = 0
var enemyLimit = 10
var wave = 1

func _ready():
	randomize()

func _on_EnemySpawnTimer_timeout():
	spawn_enemies()
	#if (wave > 2):
	spawn_asteroid()
	spawn_spinny()
	
func wave_generator():
	var enemies = get_tree().get_nodes_in_group("enemies")

	if enemies.size() == 0:
		for x in enemyLimit:
			var enemy_position = Vector2(rand_range(-100, 1054), 0)
			var new_enemy = enemy_1.instance()
			new_enemy.position = enemy_position
			add_child(new_enemy)
	
func spawn_enemies():
	var enemies = get_tree().get_nodes_in_group("enemies")
	var boss = get_tree().get_nodes_in_group("boss")
	var enemy_position = Vector2(rand_range(-100, 1054), -50)
	Score.text = str(stats.score)
	
	if spawnCounter < 10:  #spawn boss then go to level 2?
		var new_enemy = enemy_1.instance()
		new_enemy.position = enemy_position
		add_child(new_enemy)
		spawnCounter += 1
		WaveLabel.text = "WAVE 1"
		wave = 1
	elif spawnCounter == 10 && enemies.size() == 0:
		var new_boss = boss_1.instance()
		new_boss.position = enemy_position
		add_child(new_boss)
		spawnCounter += 1
		WaveLabel.text = "WAVE 2"
		wave = 2
	elif spawnCounter > 10 && spawnCounter < 20 && boss.size() == 0:
		var new_enemy = enemy_1.instance()
		new_enemy.position = enemy_position
		add_child(new_enemy)
		spawnCounter += 1
		WaveLabel.text = "WAVE 3"
		wave = 3 
	elif spawnCounter >= 20 && enemies.size() == 0 && spawnCounter <= 21:
		var new_boss = boss_1.instance()
		new_boss.position = enemy_position
		add_child(new_boss)
		spawnCounter += 1
		WaveLabel.text = "WAVE 4"
		wave = 4 
	elif enemies.size() == 0 && boss.size() == 0:
		get_parent().get_tree().change_scene("res://Win.tscn")
	
func spawn_asteroid():
	var asteroids = [Asteroid, Asteroid2]
	var asteroid_position = Vector2(rand_range(0, 1054), -50)
	var asteroid = asteroids[randi()%2].instance()
	asteroid.position = asteroid_position
	add_child(asteroid)

func spawn_spinny():
	var spinny = Spinny.instance()
	spinny.position = Vector2(rand_range(0, 1054), -50)
	add_child(spinny)
