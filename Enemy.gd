extends KinematicBody2D

var EnemyBullet = load("res://Bullet.tscn")

export (NodePath) var patrolPath
export var health = 5

onready var hurtBox = $Hurtbox
onready var animationPlayer = $BlinkAnimationPlayer

var direction = Vector2.RIGHT
var speed = 40

var bullets = 0
var playerFollow = true
var velocity = Vector2()
var shooting = false

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
	var bullet = EnemyBullet.instance()
	bullet.name = "EnemyBullet"
	if (bullets < 1):
		bullet.start($Gun.global_position, rotation_degrees - 90, 600)
		get_parent().add_child(bullet)
		bullets += 1

func _on_Timer_timeout():
	$Timer.wait_time = rand_range(1, 2)
	bullets = 0

func _on_Hurtbox_body_entered(body):
	if !"EnemyBullet" in body.name:
		health = health - 1
		if (health <= 0):
			var random = rand_range(1, 100)
			if (random > 90):
				if (stats.health < stats.max_health):
					stats.health += 1
					print('drop health!')
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
