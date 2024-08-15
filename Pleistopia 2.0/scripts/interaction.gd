extends Node2D

@onready var all_interactions = []
@onready var interact_label = $Label

@onready var dialog_canvas = $CanvasLayer
@onready var dialog_label = $CanvasLayer/ColorRect/dialog_label
@onready var is_dialog_up = false

#region Gameloop
func _ready():
	hide_dialog()
	update_interaction()

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		print("pressed E")
		trigger_interaction()
#endregion

#region Update interaction
func _on_area_entered(area):
	all_interactions.insert(0, area)
	update_interaction()

func _on_area_exited(area):
	if is_dialog_up:
		hide_dialog()
	all_interactions.erase(area)
	update_interaction()

func update_interaction():
	if all_interactions:
		interact_label.text = all_interactions[0].interact_label
	else:
		interact_label.text = ""
#endregion

#region Trigger interaction
func trigger_interaction():
	if all_interactions:
		print("An interaction triggered...")
		match all_interactions[0].interact_type:
			1 : print("This is a message") 
			2 : show_dialog()
			4 : print("This is an event")
#endregion

func show_dialog():
	is_dialog_up = true
	dialog_canvas.show()

func hide_dialog():
	is_dialog_up = false
	dialog_canvas.hide()
