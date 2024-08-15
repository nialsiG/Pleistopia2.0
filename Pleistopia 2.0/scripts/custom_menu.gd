extends CanvasLayer

@onready var level_0 = "res://scenes/level_0.tscn"
@onready var start_button = $VBoxContainer/StartButton
@onready var hull_model = $VBoxContainer/TextureRect/hull_sprite
@onready var head_model = $VBoxContainer/TextureRect/head_sprite
@onready var hull_menu_button = $VBoxContainer/GridContainer/ChooseHullButton
@onready var head_menu_button = $VBoxContainer/GridContainer/ChooseHeadButton

@export var hull_1: Texture2D
@export var hull_2: Texture2D
@export var head_1: Texture2D
@export var head_2: Texture2D

enum HullId {
	LEVEL1,
	LEVEL2
}

enum HeadId {
	LEVEL1,
	LEVEL2
}

func _ready():
	start_button.grab_focus()
	# hull
	hull_menu_button.get_popup().add_icon_item(hull_1, "Hull 1", HullId.LEVEL1)
	hull_menu_button.get_popup().add_icon_item(hull_2, "Hull 2", HullId.LEVEL2)
	hull_menu_button.get_popup().id_pressed.connect(_on_hull_menu_pressed)
	# head
	head_menu_button.get_popup().add_icon_item(head_1, "Head 1", HeadId.LEVEL1)
	head_menu_button.get_popup().add_icon_item(head_2, "Head 2", HeadId.LEVEL2)
	head_menu_button.get_popup().id_pressed.connect(_on_head_menu_pressed)

func _on_hull_menu_pressed(id: int):
	print("Hull ID: ", id)
	hull_model.texture = hull_menu_button.get_popup().get_item_icon(id)

func _on_head_menu_pressed(id: int):
	print("Head ID: ", id)
	head_model.texture = head_menu_button.get_popup().get_item_icon(id)

func _on_start_button_pressed():
	get_tree().change_scene_to_file(level_0)
