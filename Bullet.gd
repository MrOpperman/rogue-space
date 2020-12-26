extends KinematicBody2D

var movement = Vector2(1,1)
var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO

var stats = PlayerStats

var selectedGun
var weaponSpeed
var rocketSpeed = 450
export var rocket_force = 100.0

signal player_hit

func start(pos, dir, speed = 1500, gun = stats.GATLING):
	weaponSpeed = speed
	selectedGun = gun
	rotation_degrees = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)

	if gun == 0: $Bullet.visible = true
	else: $Bullet.visible = false
	if gun == 1: $Rocket.visible = true
	else: $Rocket.visible = false
	
func _physics_process(delta):
	if selectedGun == stats.GATLING: shootGatling(delta)
	elif selectedGun == stats.ROCKET: shootRocket(delta)
			
func shootGatling(delta):
	var collision = move_and_collide(velocity * delta)
	if collision: queue_free()

func shootRocket(delta):
	var enemies = get_tree().get_nodes_in_group("enemies")
	var bosses = get_tree().get_nodes_in_group("boss")
	
	if !enemies && !bosses: shootGatling(delta)
	else:
		acceleration += seek()
		velocity += acceleration * delta
		velocity = velocity.clamped(rocketSpeed)
		rotation = velocity.angle()
		shootGatling(delta)
			
func findTarget():
	var enemies = get_tree().get_nodes_in_group("enemies")
	var bosses = get_tree().get_nodes_in_group("boss")
	var targets
	
	if (enemies):
		targets = enemies
	elif (bosses):
		targets = bosses
	else: targets = false
	
	if (targets):
		var positions = []
		for enemy in targets:
			positions.append(position.distance_to(enemy.position))
		var target = targets[positions.find(positions.min())]
	
		return target
	else: return null
	
func seek():
	var target = findTarget()
	var steer = Vector2.ZERO

	if target:
		var desired = (target.position - position).normalized() * rocketSpeed
		steer = (desired - velocity).normalized() * rocket_force
	return steer

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Area2D_body_entered(body):
	queue_free()

