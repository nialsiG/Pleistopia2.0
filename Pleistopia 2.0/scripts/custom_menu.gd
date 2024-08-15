extends Control

@onready var level_0 = "res://scenes/level_0.tscn"
@onready var start_button = $VBoxContainer/StartButton

func _ready():
	start_button.grab_focus()

func _on_start_button_pressed():
	get_tree().change_scene_to_file(level_0)

func _on_choose_hull_button_toggled(toggled_on):
	print("An hull has been selected")

func _on_choose_head_button_toggled(toggled_on):
	print("An head has been selected")
