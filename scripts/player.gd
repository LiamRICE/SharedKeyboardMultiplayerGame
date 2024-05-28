extends CharacterBody2D

# player stats
const air_acceleration: int = 1200
const ground_acceleration: int = 4000
const speed: int = 400
const jump_velocity: int = 800
var is_grounded: bool = false

# player motion
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var movement: Vector2 = Vector2.ZERO

# character information
var health: int = 10

func _ready():
	pass

func _process(delta):
	# check if in the air
	if is_on_wall():
		movement.x = 0
	if is_on_ceiling():
		movement.y = 0
	if not is_on_floor():
		is_grounded = false
		movement.y += gravity * delta
	else: # if on floor can jump and move
		movement.y = 0
		is_grounded = true
		if Input.is_action_pressed("jump"):
			movement.y = -jump_velocity
	
	var acceleration = air_acceleration
	if is_grounded:
		acceleration = ground_acceleration
	
	var dir: int = Input.get_axis("left", "right")
	if movement.x < speed and movement.x > -speed:
		movement.x += dir * acceleration * delta
	elif movement.x >= speed and dir < 0:
		movement.x += dir * acceleration * delta
	elif movement.x <= -speed and dir > 0:
		movement.x += dir * acceleration * delta
	
	print("Movement :",movement.x)
	
	# zero out if no motion
	if dir == 0:
		if is_grounded:
			if movement.x > 0:
				movement.x += -1 * acceleration * delta * log(movement.x/100 + 1)
			else:
				movement.x += 1 * acceleration * delta * log(-movement.x/100 + 1)
			if abs(movement.x) < 50:
				movement.x = 0
	
	print("Clean :",movement.x)
	velocity = movement
	move_and_slide()

func take_damage(damage: int):
	health -= damage
	if health <= 0:
		queue_free()
		
func special_action():
	pass

func attack():
	pass

func secondary_action():
	pass

