extends BaseCharacter

@export var player_node: Node2D
@export var attack_damage: int
@export var knockback_force: int
@export var stun_time: float
@export var character_type: String

@onready var sprite_2d = $Sprite2D

const TILE_SIZE = 16

var attack_speed: float

func _ready():
	player_node.player_did_an_action.connect(_move_to_mouse)

func _move_to_mouse():
	is_moving_to_destination = true
	wandering = false
	destination_position = (get_global_mouse_position() / movement_script.TILE_SIZE).floor()
	move_to_destination()

func _on_hitbox_component_area_entered(_area):
	pass
