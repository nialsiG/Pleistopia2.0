extends CharacterBody2D
class_name Sentinel

@export var CAN_MOVE = true
@export var SHOW_HUD = true
@export var MAX_SPEED = 500
@export var ROTATION_SPEED = 3
@export var ACCELERATION = 1500
@export var FRICTION = 1200
@export var LIMITS = {"Left": -10000000, "Top": -10000000, "Right": 10000000, "Bottom": 10000000}
@export var HEAD: Texture2D
@export var HULL: Texture2D
@export var ZOOM_FACTOR = 1

@onready var axis = Vector2.ZERO
@onready var rotation_input = 0
@onready var camera2D = $Camera2D
@onready var head = $hull_sprite/head_sprite
@onready var hull = $hull_sprite
@onready var camera = $Camera2D

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
	var input = int(Input.is_action_pressed("move_up")) - int(Input.is_action_pressed("move_down"))
	axis.x = input * cos(rotation)
	axis.y = input * sin(rotation)

func get_input_rotation():
	rotation_input = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	

func apply_friction(amount):
	if velocity.length() >= amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func apply_acceleration(amount):
	velocity += amount
	velocity = velocity.limit_length(MAX_SPEED)

func move(delta):
	# rotation
	get_input_rotation()
	rotation += rotation_input * delta * ROTATION_SPEED
	# translation
	get_input_axis()
	# Change velocity accordingly
	if axis == Vector2.ZERO:
		apply_friction(FRICTION * delta)
		camera_zoom_out(delta)
	else:
		apply_acceleration(ACCELERATION * axis * delta)
		camera_zoom_in(delta)
#endregion

#region move_head
func move_head():
	head.look_at(get_global_mouse_position())
#endregion

#region camera
func camera_zoom_in(delta):
	if ZOOM_FACTOR < 1.05:
		ZOOM_FACTOR += delta / 10
		camera.zoom = Vector2(1,1) * ZOOM_FACTOR
	elif ZOOM_FACTOR > 1.05:
		ZOOM_FACTOR = 1.05
		camera.zoom = Vector2(1,1) * ZOOM_FACTOR

func camera_zoom_out(delta):
	if ZOOM_FACTOR > 1:
		ZOOM_FACTOR -= delta / 10
		camera.zoom = Vector2(1,1) * ZOOM_FACTOR
	elif ZOOM_FACTOR < 1:
		ZOOM_FACTOR = 1
		camera.zoom = Vector2(1,1) * ZOOM_FACTOR
