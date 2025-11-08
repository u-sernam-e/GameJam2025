extends Node
class_name MovementComponent


const TILE_SIZE = 16

# Internal movement variables
var pathfinding_grid: AStarGrid2D = AStarGrid2D.new()
var path: Array = []
var destination_position: Vector2
var destination: Node

var has_wander_direction: bool = false
var wander_direction_list: Array = [Vector2(1, 0), Vector2(-1, 0), Vector2(0, -1), Vector2(0, 1)]
var current_wander_direction: String
var direction: Vector2
var is_moving_to_destination: bool = false
var movement_timer: float = 0.1

var wandering: bool = false
var place_of_interest_spotted: bool = false

var last_position: Vector2
var is_moving: bool = false
var movement_cooldown: float = 0.5
var current_movement_timer: float = 0.0
var has_moved_a_frame: int = 0
var tween: Tween

var character: CharacterBody2D

func _ready():
	character = get_parent()
	var tilemap_layer_node = character.tilemap_layer_node

	pathfinding_grid.region = tilemap_layer_node.get_used_rect()
	pathfinding_grid.cell_size = Vector2(TILE_SIZE, TILE_SIZE)
	pathfinding_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	pathfinding_grid.update()

	for cell in tilemap_layer_node.get_used_cells():
		pathfinding_grid.set_point_solid(cell, true)

	if character.visual_path_line2D:
		character.visual_path_line2D.global_position = Vector2(TILE_SIZE / 2.0, TILE_SIZE / 2.0)
	
	has_wander_direction = false
	current_wander_direction = "Right"
	last_position = character.global_position

func _physics_process(delta):
	if is_moving_to_destination or wandering:
		if character.global_position != last_position:
			current_movement_timer = movement_cooldown
			is_moving = true
		else:
			current_movement_timer -= delta
			if current_movement_timer <= 0.0:
				is_moving = false

		last_position = character.global_position

		if not is_moving:
			has_moved_a_frame += 1
			if has_moved_a_frame >= 5:
				has_moved_a_frame = 0
				is_moving_to_destination = false
				wandering = false
				character.state_interruptor.reset_to_idle()

func move_to_destination():
	while is_moving_to_destination:
		path = pathfinding_grid.get_point_path(
			(character.global_position / TILE_SIZE).floor(),
			destination_position.floor()
		)

		if path.size() > 1:
			path.remove_at(0)
			var go_to_pos = path[0] + Vector2(TILE_SIZE / 2.0, TILE_SIZE / 2.0)

			if go_to_pos.x != character.global_position.x:
				character.sprite_2d.flip_h = go_to_pos.x < character.global_position.x

			tween = create_tween()
			tween.tween_property(character, "global_position", go_to_pos, movement_timer)\
				.set_trans(Tween.TRANS_SINE)\
				.set_ease(Tween.EASE_IN_OUT)
			await tween.finished

			if character.visual_path_line2D:
				character.visual_path_line2D.points = path
		else:
			is_moving_to_destination = false
