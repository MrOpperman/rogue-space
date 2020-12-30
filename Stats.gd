extends Node

enum {
	GATLING,
	ROCKET
}

export(int) var max_health = 3 setget set_max_health
var health = max_health setget set_health
var gun = GATLING setget set_gun
var score = 0 setget set_score
var muscle_powerup = false setget muscle_powerup_toggle

var powerup_length = 10

signal health_changed(value)
signal max_health_changed(value)
signal gun_changed
signal muscle_powerup_start
signal muscle_powerup_stop

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
	
func muscle_powerup_toggle(value):
	if (value): emit_signal("muscle_powerup_start")
	else: emit_signal("muscle_powerup_stop")
