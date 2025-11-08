extends Camera2D

var roomSize : Vector2 = Vector2(640, 320)

func _ready():
	Globals.moveCamera.connect(_moveCamera)
	
func _moveCamera(moveAmount : Vector2i):
	position += Vector2(moveAmount) * roomSize

func _input(event: InputEvent) -> void:
	if Globals.level_state == "Inspection":
		if event.is_action_pressed("ui_right"):
			Globals.moveCamera.emit(Vector2i(1, 0))
		if event.is_action_pressed("ui_left"):
			Globals.moveCamera.emit(Vector2i(-1, 0))
			
func _level_change(direction: String):
	if direction == "Right":
		Globals.moveCamera.emit(Vector2i(1, 0))
	if direction == "Left":
		Globals.moveCamera.emit(Vector2i(-1, 0))
		
func _activate_screen_shake():
	pass
		
