extends Camera2D

@onready var up = $Up
@onready var down = $Down
@onready var left = $Left
@onready var right = $Right

var roomSize : Vector2 = Vector2(640, 320)

func _ready():
	Globals.moveCamera.connect(_moveCamera)
	
func _moveCamera(moveAmount : Vector2i):
	position += Vector2(moveAmount) * roomSize
	Globals.updateTileMap.emit()

func _input(event: InputEvent) -> void:
	if Globals.level_state == "Inspection":
		if event.is_action_pressed("ui_right") and !right.has_overlapping_areas():
			Globals.moveCamera.emit(Vector2i(1, 0))
		if event.is_action_pressed("ui_left") and !left.has_overlapping_areas():
			Globals.moveCamera.emit(Vector2i(-1, 0))
		if event.is_action_pressed("ui_up") and !up.has_overlapping_areas():
			Globals.moveCamera.emit(Vector2i(0, -1))
		if event.is_action_pressed("ui_down") and !down.has_overlapping_areas():
			Globals.moveCamera.emit(Vector2i(0, 1))

func _level_change(direction: String):
	if direction == "Right":
		Globals.moveCamera.emit(Vector2i(1, 0))
	if direction == "Left":
		Globals.moveCamera.emit(Vector2i(-1, 0))
	if direction == "Up":
		Globals.moveCamera.emit(Vector2i(0, -1))
	if direction == "Down":
		Globals.moveCamera.emit(Vector2i(0, 1))
		
func _activate_screen_shake():
	pass
