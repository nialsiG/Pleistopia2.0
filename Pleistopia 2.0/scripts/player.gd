extends CharacterBody2D

@export var MAX_SPEED = 500
@export var ACCELERATION = 1500
@export var FRICTION = 1200

@onready var axis = Vector2.ZERO

#region Gameloop
func _process(delta):
	move(delta)

func _physics_process(delta):
	move_and_slide()
#endregion

#region Movement
func get_input_axis():
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))

func apply_friction(amount):
	if velocity.length() >= amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func apply_acceleration(amount):
	velocity += amount
	velocity = velocity.limit_length(MAX_SPEED)

func move(delta):
	get_input_axis()
	# Change velocity accordingly
	if axis == Vector2.ZERO:
		apply_friction(FRICTION * delta)
	else:
		apply_acceleration(ACCELERATION * axis * delta)
#endregion
