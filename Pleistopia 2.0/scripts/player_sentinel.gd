extends CharacterBody2D
class_name Sentinel

@export var MAX_SPEED = 500
@export var ACCELERATION = 1500
@export var FRICTION = 1200
@export var LIMITS = {"Left": -10000000, "Top": -10000000, "Right": 10000000, "Bottom": 10000000}
@export var SPRITE : Texture2D

@onready var axis = Vector2.ZERO
@onready var sprite = $Sprite2D
@onready var camera2D = $Camera2D

#region Gameloop
func _ready():
	sprite.texture = SPRITE
	camera2D.limit_left = LIMITS["Left"]
	camera2D.limit_top = LIMITS["Top"]
	camera2D.limit_right = LIMITS["Right"]
	camera2D.limit_bottom = LIMITS["Bottom"]

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
