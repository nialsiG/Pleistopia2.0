extends CanvasLayer

@onready var start_file = "res://scenes/world.tscn"

@onready var title_container = $VBoxContainer
@onready var settings_container = $VBoxContainer2

@onready var start_button = $VBoxContainer/Button_new_game
@onready var back_button = $VBoxContainer2/Button_back

#region Gameloop
func _ready():
	show_title()
#endregion

#region Events
func _on_button_new_game_pressed():
	get_tree().change_scene_to_file(start_file)

func _on_button_load_game_pressed():
	pass # Replace with function body.

func _on_button_settings_pressed():
	show_settings()

func _on_button_quit_pressed():
	get_tree().quit()

func _on_button_back_pressed():
	show_title()
#endregion

#region Methods
func show_title():
	settings_container.hide()
	title_container.show()
	start_button.grab_focus()

func show_settings():
	title_container.hide()
	settings_container.show()
	back_button.grab_focus()
#endregion
