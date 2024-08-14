extends Control

@onready var level_0 = "res://scenes/level_0.tscn"
@onready var first_button = $VBoxContainer/GridContainer/HBoxContainer/CheckButton

func _ready():
	first_button.grab_focus()

func _process(delta):
	pass

func _on_button_pressed():
	get_tree().change_scene_to_file(level_0)
