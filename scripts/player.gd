extends CharacterBody2D

class_name Player

# player stats
const air_acceleration: int = 1200
const ground_acceleration: int = 4000
const speed: int = 400
const jump_velocity: int = 800
var is_grounded: bool = false

# player motion
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var movement: Vector2 = Vector2.ZERO
var dir: int = 0
var acceleration: int = ground_acceleration
var jump_vel = jump_velocity

# character information
var health: int = 10

func _ready():
	pass

func _process(delta):
	#========== MOVEMENT ==========#
	# get left-right movement
	dir = Input.get_axis("left", "right")
	# check is on floor
	if not is_on_floor():
		is_grounded = false
	# check if in the air
	else: # if on floor can jump and move
		movement.y = 0
		is_grounded = true
		if Input.is_action_pressed("jump"):
			movement.y = -jump_velocity
	if is_on_ceiling():
		movement.y = 0
	# check if running into wall
	if is_on_wall():
		print("is on wall")
		movement.x = 0
		# if is on wall can climb with left and up
		var normal: float = get_wall_normal().x
		print(Input.is_action_pressed("jump") and ((normal > 0 and dir < 0) or (normal < 0 and dir > 0)))
		if Input.is_action_pressed("jump") and ((normal > 0 and dir < 0) or (normal < 0 and dir > 0)):
			jump_vel = jump_velocity/2
			movement.y = -jump_vel
			if dir < 0:
				movement.x = jump_vel/3
			if dir > 0:
				movement.x = -jump_vel/3
	else:
		jump_vel = jump_velocity
	# setting acceleration to air_acceleration if in the air
	acceleration = air_acceleration
	if is_grounded:
		acceleration = ground_acceleration
	
	#========== ACTIONS ==========#
	if Input.is_action_just_pressed("primary_action"):
		primary_action()
	if Input.is_action_just_pressed("secondary_action"):
		secondary_action()
	if Input.is_action_just_pressed("special_action"):
		special_action()

func _physics_process(delta):
	#========== PHYSICS ==========#
	# handle gravity
	if not is_grounded:
		movement.y += gravity * delta
	# handle motion
	if movement.x < speed and movement.x > -speed:
		movement.x += dir * acceleration * delta
	elif movement.x >= speed and dir < 0:
		movement.x += dir * acceleration * delta
	elif movement.x <= -speed and dir > 0:
		movement.x += dir * acceleration * delta
	# zero out if no motion
	if dir == 0:
		if is_grounded:
			if movement.x > 0:
				movement.x += -1 * acceleration * delta * log(movement.x/100 + 1)
			else:
				movement.x += 1 * acceleration * delta * log(-movement.x/100 + 1)
			if abs(movement.x) < 50:
				movement.x = 0
	velocity = movement
	move_and_slide()
	extended_process(delta)

func take_damage(damage: int, _ignore: bool):
	health -= damage
	if health <= 0:
		queue_free()
		
func special_action():
	pass

func primary_action():
	pass

func secondary_action():
	pass

func extended_process(delta: float):
	pass
