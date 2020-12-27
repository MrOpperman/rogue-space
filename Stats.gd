extends Node

enum {
	GATLING,
	ROCKET
}

export(int) var max_health = 3 setget set_max_health
var health = max_health setget set_health
var gun = GATLING setget set_gun
var score = 0 setget set_score

signal health_changed(value)
signal max_health_changed(value)
signal gun_changed

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	
func set_gun(value):
	gun = value
	emit_signal("gun_changed")
	
func set_score(value):
	score = value

func _ready():
	self.health = max_health
