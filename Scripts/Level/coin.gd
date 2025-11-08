extends Node2D

var character : BaseCharacter

@onready var collision_box = $Area2D

func _ready() -> void:
	character = get_tree().get_first_node_in_group("character")
	collision_box.area_entered.connect(_character_touched)

func _process(delta: float) -> void:
	position = lerp(position, to_local(character.global_position), delta)

func _character_touched(_area : Area2D):
	Globals.setCoins.emit(Globals.coins + 1)
	queue_free()
