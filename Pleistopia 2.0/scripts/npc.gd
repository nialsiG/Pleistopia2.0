extends CharacterBody2D
class_name NPC

@export_flags("message", "dialog", "event") var interact_type = 0
@export var interact_label = "Press E"
@export var message = "..."

@onready var interact_area = $interact_area

func _ready():
	interact_area.interact_type = interact_type
	interact_area.interact_label = interact_label
	interact_area.message = message
