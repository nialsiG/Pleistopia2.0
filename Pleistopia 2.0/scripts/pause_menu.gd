extends Control

@onready var start_menu = "res://scenes/main_menu.tscn"
@onready var pause_panel = $Panel

static var is_paused: bool

func _ready():
	is_paused = true
	pause_unpause()

func _process(delta):
	if Input.is_action_just_pressed("pause_unpause"):
		pause_unpause()

func pause_unpause():
	if is_paused:
		pause_panel.hide()
	else:
		pause_panel.show()
		$Panel/VBoxContainer/ResumeButton.grab_focus()
	is_paused = !is_paused

func _on_resume_button_pressed():
	pause_unpause()

func _on_save_button_pressed():
	pass # Replace with function body.

func _on_go_back_to_menu_button_pressed():
	get_tree().change_scene_to_file(start_menu)



