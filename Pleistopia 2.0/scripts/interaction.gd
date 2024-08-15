extends Node2D

@onready var all_interactions = []
@onready var interact_label = $Label

#region Gameloop
func _ready():
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
			2 : print("This is a dialog")
			4 : print("This is an event")
#endregion
