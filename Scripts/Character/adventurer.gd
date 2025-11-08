extends BaseCharacter

@export var player_node: Node2D
@export var character_type: String

@onready var sprite_2d = $Sprite2D
@onready var activate_collision = $ActivateCollision
@onready var coin_collision = $CoinCollision
@onready var hurtbox = $Hurtbox

const TILE_SIZE = 16

var attack_speed: float

func _ready():
	player_node.player_did_an_action.connect(_move_to_mouse)
	hurtbox.body_entered.connect(_death_body_entered)
	Globals.updateTileMap.connect(_updateTileMap)

func _move_to_mouse():
	is_moving_to_destination = true
	destination_position = (get_global_mouse_position() / movement_script.TILE_SIZE).floor()
	move_to_destination()

func _updateTileMap():
	call_deferred("update_pathfinding_grid")

func do_action():
	for b in activate_collision.get_overlapping_areas():
		if b is CharacterActivateable:
			b.activate()

func die():
	queue_free()

func _death_body_entered(_body : Node2D):
	die()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("RightClick"):
		do_action()
