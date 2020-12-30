extends ColorRect

var stats = PlayerStats

func _ready():
	stats.connect("muscle_powerup_start", self, "muscle_powerup_started")
	stats.connect("muscle_powerup_stop", self, "muscle_powerup_ended")

func muscle_powerup_started():
	visible = true

func muscle_powerup_ended():
	visible = false
