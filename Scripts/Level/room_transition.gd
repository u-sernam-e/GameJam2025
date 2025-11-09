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
		print(connected_room)
		if Globals.level_state == "Execution":
			Globals.change_screen = true
			camera._level_change(connected_room)

func _on_area_exited(area):
	if area.is_in_group("character"):
		if Globals.level_state == "Execution":
			if connected_room == "Right":
				connected_room = "Left"
			elif connected_room == "Left":
				connected_room = "Right"
			elif connected_room == "Up":
				connected_room = "Down"
			elif connected_room == "Down":
				connected_room = "Up"
			print(connected_room)
