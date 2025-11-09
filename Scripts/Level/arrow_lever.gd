extends Area2D

@export var itemToActivate : BlockActivateable

@onready var sprite = $Sprite2D

func _ready() -> void:
	area_entered.connect(_area_entered)
	
func _area_entered(area : Area2D):
	if area.is_in_group("arrow"):
		if sprite.frame == 0:
			sprite.frame = 1
		else:
			sprite.frame = 0
		itemToActivate.activate()
