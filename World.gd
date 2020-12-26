extends Node2D

var enemy_1 = preload("res://Enemy.tscn")
var boss_1 = preload("res://Boss.tscn")
var spawnCounter = 0
var enemyLimit = 10
var wave = 1

func _ready():
	randomize()

func _on_EnemySpawnTimer_timeout():
	spawn_enemies()
	
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
	var enemy_position = Vector2(rand_range(-100, 1054), 0)
	
	if spawnCounter < 10:  #spawn boss then go to level 2?
		var new_enemy = enemy_1.instance()
		new_enemy.position = enemy_position
		add_child(new_enemy)
		spawnCounter += 1
	elif spawnCounter == 10 && enemies.size() == 0:
		var new_boss = boss_1.instance()
		new_boss.position = enemy_position
		add_child(new_boss)
		spawnCounter += 1
	elif spawnCounter > 10 && spawnCounter < 20 && boss.size() == 0:
		var new_enemy = enemy_1.instance()
		new_enemy.position = enemy_position
		add_child(new_enemy)
		spawnCounter += 1
	elif spawnCounter >= 20 && enemies.size() == 0 && spawnCounter <= 21:
		var new_boss = boss_1.instance()
		new_boss.position = enemy_position
		add_child(new_boss)
		spawnCounter += 1
	elif enemies.size() == 0 && boss.size() == 0:
		get_parent().get_tree().change_scene("res://Win.tscn")
	
