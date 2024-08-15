extends CharacterBody2D
class_name Sentinel

@export var CAN_MOVE = true
@export var MAX_SPEED = 500
@export var ACCELERATION = 1500
@export var FRICTION = 1200
@export var LIMITS = {"Left": -10000000, "Top": -10000000, "Right": 10000000, "Bottom": 10000000}
@export var HEAD: Texture2D
@export var HULL: Texture2D

@onready var axis = Vector2.ZERO
@onready var camera2D = $Camera2D
@onready var head = $hull_sprite/head_sprite
@onready var hull = $hull_sprite

static var current_head: Texture2D
static var current_hull: Texture2D

#region Gameloop
func _ready():
	print("current head=", current_head)
	print("current hull=", current_hull)
	if current_head == null:
		current_head = HEAD
	if current_hull == null:
		current_hull = HULL
	print("current head=", current_head)
	print("current hull=", current_hull)
	update_aspect()
	camera2D.limit_left = LIMITS["Left"]
	camera2D.limit_top = LIMITS["Top"]
	camera2D.limit_right = LIMITS["Right"]
	camera2D.limit_bottom = LIMITS["Bottom"]

func _process(delta):
	if CAN_MOVE:
		move(delta)

func _physics_process(delta):
	move_and_slide()
	move_head()
#endregion

#region customize
func update_aspect():
	head.texture = current_head
	hull.texture = current_hull
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

#region move_head
func move_head():
	head.look_at(get_global_mouse_position())
#endregion
