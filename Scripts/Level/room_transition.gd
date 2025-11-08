extends Area2D

@export var connected_room: String
@export var camera: Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_area_entered(area):
	if area.is_in_group("character"):
		if Globals.level_state == "Execution":
			Globals.change_screen = true
			camera._level_change(connected_room)
