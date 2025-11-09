extends Area2D
class_name CharacterActivateable

func activate():
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftClick") and get_global_mouse_position().distance_to(global_position) < 10 and Globals.level_state == "Inspection":
		activate()
