extends Area2D

@export var itemToActivate : BlockActivateable

@onready var sprite = $Sprite2D

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("character") or area.is_in_group("crate"):
		itemToActivate.activate()
		sprite.frame = 1

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("character") or area.is_in_group("crate"):
		itemToActivate.activate()
		sprite.frame = 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftClick") and get_global_mouse_position().distance_to(global_position) < 10 and Globals.level_state == "Inspection":
		itemToActivate.activate()
