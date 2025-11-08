extends BaseCharacter

@export var player_node: Node2D
@export var character_type: String

@onready var sprite_2d = $Sprite2D
@onready var lever_collision = $LeverCollision

const TILE_SIZE = 16

var attack_speed: float

func _ready():
	player_node.player_did_an_action.connect(_move_to_mouse)
	Globals.activate.connect(_activate)
	_activate(0) # calls this to update tilemap after gates spawn

func _move_to_mouse():
	is_moving_to_destination = true
	wandering = false
	destination_position = (get_global_mouse_position() / movement_script.TILE_SIZE).floor()
	move_to_destination()

func _activate(_inId):
	call_deferred("update_pathfinding_grid")

func do_action():
	for b in lever_collision.get_overlapping_areas():
		if b is Lever:
			b.activate()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("RightClick"):
		do_action()
