extends Control
@onready var animation_player = $TransitionController/ColorRect/AnimationPlayer
func _on_button_pressed() -> void:
	animation_player.play("fadeout")
	get_tree().change_scene_to_file("res://Scenes/Level/main_level.tscn")
