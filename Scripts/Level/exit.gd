extends Node2D

@export var nextLevel : PackedScene

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("character"):
		Globals.level_state = "Inspection"
		get_tree().change_scene_to_packed(nextLevel)
		Globals.coin_count += 5
