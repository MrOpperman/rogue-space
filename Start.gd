extends Control

func _physics_process(delta):
	if Input.is_action_pressed('ui_accept'):
		get_parent().get_tree().change_scene("res://World.tscn")

func _on_Button_pressed():
	get_parent().get_tree().change_scene("res://World.tscn")
