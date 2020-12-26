extends ColorRect

enum {
	GATLING,
	ROCKET
}

var stats = PlayerStats
onready var GatlingSprite = $Gatling
onready var RocketSprite = $Rocket

func _ready():
	stats.connect("gun_changed", self, "change_gun")
	
func change_gun():
	hide_all_guns()
	if (stats.gun == 0):
		GatlingSprite.visible = true
	if (stats.gun == 1):
		RocketSprite.visible = true
		
func hide_all_guns():
	GatlingSprite.visible = false
	RocketSprite.visible = false
