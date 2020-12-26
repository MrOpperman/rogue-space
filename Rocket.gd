extends Area2D

var stats = PlayerStats

func _on_Rocket_body_entered(body):
	stats.gun = stats.ROCKET
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _physics_process(delta):
	position.y += 100 * delta
