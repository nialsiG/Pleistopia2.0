extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_button_new_game_pressed():
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_button_load_game_pressed():
	pass # Replace with function body.

func _on_button_settings_pressed():
	pass # Replace with function body.

func _on_button_quit_pressed():
	get_tree().quit()
