extends Control

@onready var ui = UI

func _ready():
	UI.hide()
	Globals.setFilter.emit(2)

func _on_button_pressed() -> void:
	Globals.setFilter.emit(0)
	get_tree().change_scene_to_file("res://Scenes/Tavern/tavern_1.tscn")
	
