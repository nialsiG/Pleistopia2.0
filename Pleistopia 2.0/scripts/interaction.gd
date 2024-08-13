extends Node2D

@onready var all_interactions = []
@onready var interact_label = $Label

#region Gameloop
func _ready():
	update_interaction()

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		interact()
#endregion

func _on_area_2d_area_entered(area):
	all_interactions.insert(0, area)
	update_interaction()

func _on_area_2d_area_exited(area):
	all_interactions.erase(area)
	update_interaction()

func update_interaction():
	if all_interactions:
		interact_label.text = all_interactions[0].interact_label
	else:
		interact_label.text = ""

func interact():
	if all_interactions:
		var current = all_interactions[0]
		match current.interact_type:
			"go_to_custom_menu" : get_tree().change_scene_to_file("res://scenes/custom_menu.tscn")
