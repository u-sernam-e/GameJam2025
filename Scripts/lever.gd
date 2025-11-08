extends Area2D
class_name Lever

@export var id : int

@onready var onSprite = $On
@onready var offSprite = $Off

func activate():
	Globals.activate.emit(id)
	
	onSprite.visible = !onSprite.visible
	offSprite.visible = !offSprite.visible
