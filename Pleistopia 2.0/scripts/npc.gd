extends CharacterBody2D
class_name NPC

@export var interact_label = "none"
@export var interact_type = "none"

func _ready():
	var interact_area = $interact_area
	interact_area.interact_label = interact_label
	interact_area.interact_type = interact_type
