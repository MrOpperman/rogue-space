extends Area2D

var stats = PlayerStats

var moving = true
var activated = false

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _physics_process(delta):
	position.y += 100 * delta

func _on_Muscle_body_entered(body):
	$Timer.start()
	$Collider.free()
	$ColorRect.free()
	$Sprite.free()
	
	stats.muscle_powerup = true

func _on_Timer_timeout():
	stats.muscle_powerup = false
	queue_free()
