extends KinematicBody2D

var Bullet = load("res://Bullet.tscn")
var Rocket = load("res://Rocket.tscn")

export (NodePath) var patrolPath
export var health = 15

onready var hurtBox = $Hurtbox
onready var animationPlayer = $BlinkAnimationPlayer

var direction = Vector2.RIGHT
var speed = 50

var bullets = 0
var playerFollow = true
var velocity = Vector2()
var shooting = true
var stats = PlayerStats

func _ready():
	randomize()

func _physics_process(delta):
	var player = get_parent().get_node("Player")
	# Face the player
	if player:
		rotation_degrees = rad2deg((player.position -  position).angle()) + 90
	if player && playerFollow:
		velocity = position.direction_to(player.position) * speed
	elif !playerFollow:
		velocity = Vector2()
		
	velocity = move_and_slide(velocity)
	
	if shooting: shoot()
		
func shoot():
	var bullet = Bullet.instance()
	var bullet2 = Bullet.instance()
	var bullet3 = Bullet.instance()
	
	bullet.name = "EnemyBullet"
	bullet2.name = "EnemyBullet"
	bullet3.name = "EnemyBullet"
	
	if (bullets < 1):
		bullet.start($Gun1.global_position, rotation_degrees - 90, 600)
		bullet2.start($Gun2.global_position, rotation_degrees - 90, 600)
		bullet3.start($Gun3.global_position, rotation_degrees - 90, 600)

		get_parent().add_child(bullet)
		get_parent().add_child(bullet2)
		get_parent().add_child(bullet3)
		bullets += 1

func _on_Timer_timeout():
	$Timer.wait_time = 1
	bullets = 0

func _on_Hurtbox_body_entered(body):
	if !"EnemyBullet" in body.name:
		health = health - 1
		if (health <= 0):
			var rocket = Rocket.instance()
			rocket.position = position
			get_parent().add_child(rocket)
			
			stats.score += 100
			queue_free()
		hurtBox.start_invincibility(0.4)

func _on_Hurtbox_invinciblity_ended():
	animationPlayer.play("Stop")

func _on_Hurtbox_invinciblity_started():
	animationPlayer.play("Start")

func _on_Area2D_body_entered(body):
	if body.name == "Player": shooting = true

func _on_Area2D_body_exited(body):
	if body.name == "Player": shooting = false
