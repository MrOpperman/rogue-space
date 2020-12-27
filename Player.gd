extends KinematicBody2D

var Bullet = load("res://Bullet.tscn")
 
onready var sprite = $PlayerSprite
onready var hurtBox = $Hurtbox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer
onready var screen_size = get_viewport_rect().size

var stats = PlayerStats

var speed = 350
var velocity = Vector2()
var bullets = 0

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		rotation_degrees = 90
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		rotation_degrees = -90
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		rotation_degrees = -180
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		rotation_degrees = 0
		velocity.y -= 1
	if Input.is_action_pressed('ui_accept'):
		shoot()
		
	# wrap around the screen
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)

	velocity = velocity.normalized() * speed
	
func shoot():
	if stats.gun == stats.GATLING: $Timer.wait_time = 0.15
	else: $Timer.wait_time = 0.30
	var bullet = Bullet.instance()
	bullets = bullets + 1
	if (bullets <= 1): 
		bullet.start($Gun.global_position, rotation_degrees - 90, 1500, stats.gun)
		get_parent().add_child(bullet)

func _physics_process(delta):
	get_input()
	move_and_collide(velocity * delta)
	if (stats.health <= 0):
		queue_free()
		get_parent().get_tree().change_scene("res://GameOver.tscn")
		stats.health = 3

func _on_Timer_timeout():
	bullets = 0
	
func take_damage(): 
	if (!hurtBox.invincible):
		stats.health -= 0.5
	hurtBox.start_invincibility(0.6)
	hurtBox.create_hit_effect()

func _on_Hurtbox_body_entered(body):
	take_damage()

func _on_Hurtbox_invinciblity_started():
	blinkAnimationPlayer.play("Start")

func _on_Hurtbox_invinciblity_ended():
	blinkAnimationPlayer.play("Stop")

func _on_Hurtbox_area_entered(area):
	take_damage()
