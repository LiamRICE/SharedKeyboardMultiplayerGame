extends CharacterBody2D

const acceleration = 500
const speed: float = 500
const jump_velocity = 600
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass

func _process(delta):
	# check if in the air
	if not is_on_floor():
		velocity.y += gravity * delta
	else: # if on floor can jump and move
		if Input.is_action_just_pressed("jump"):
			velocity.y = -jump_velocity
		
	var commands: float = Input.get_axis("left", "right")
	velocity.x = commands * speed
	
	move_and_slide()
