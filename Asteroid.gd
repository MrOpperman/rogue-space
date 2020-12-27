extends Area2D

onready var hurtBox = $Hurtbox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer

var health = 1.5

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var angle = rand_range(0, 360)
	rotation_degrees = angle

func _process(delta):
	position.y += 300 * delta

func _on_Hurtbox_body_entered(body):
	hurtBox.start_invincibility(0.3)
	health -= 1
	if (health <= 0): queue_free()

func _on_Hurtbox_invinciblity_started():
	blinkAnimationPlayer.play("Start")

func _on_Hurtbox_invinciblity_ended():
	blinkAnimationPlayer.play("Stop")
