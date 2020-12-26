extends Control

var stats = PlayerStats

func _on_Button_pressed():
	queue_free()
	get_parent().get_tree().change_scene("res://World.tscn")
	stats.health = 3
