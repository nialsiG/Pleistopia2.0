extends Area2D

@export_file("*.tscn", "*.scn") var target_scene

func _on_body_entered(body):
	print("Player entered a door")
	get_tree().change_scene_to_file(target_scene)
