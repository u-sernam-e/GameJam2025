extends CharacterActivateable

@export var itemToActivate : BlockActivateable

@onready var onSprite = $On
@onready var offSprite = $Off

func activate():
	itemToActivate.activate()
	
	onSprite.visible = !onSprite.visible
	offSprite.visible = !offSprite.visible

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("MiddleClick"):
		activate()
