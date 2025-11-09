extends Area2D

@export var itemToActivate : BlockActivateable

@onready var sprite = $Sprite2D

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("character") or area.is_in_group("crate"):
		itemToActivate.activate()
		sprite.frame = 1

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("character") or area.is_in_group("crate"):
		itemToActivate.activate()
		sprite.frame = 0
