extends CharacterBody2D
class_name BaseCharacter

@export var movement_script: MovementComponent
@export var tilemap_layer_node: TileMapLayer
@export var visual_path_line2D: Line2D

var pathfinding_grid: AStarGrid2D:
	get: return movement_script.pathfinding_grid
	set(v): movement_script.pathfinding_grid = v

var path:
	get: return movement_script.path
	set(v): movement_script.path = v

var destination_position:
	get: return movement_script.destination_position
	set(v): movement_script.destination_position = v

var destination:
	get: return movement_script.destination
	set(v): movement_script.destination = v

var has_wander_direction:
	get: return movement_script.has_wander_direction
	set(v): movement_script.has_wander_direction = v

var wander_direction_list:
	get: return movement_script.wander_direction_list
	set(v): movement_script.wander_direction_list = v

var current_wander_direction:
	get: return movement_script.current_wander_direction
	set(v): movement_script.current_wander_direction = v

var direction:
	get: return movement_script.direction
	set(v): movement_script.direction = v

var is_moving_to_destination:
	get: return movement_script.is_moving_to_destination
	set(v): movement_script.is_moving_to_destination = v

var movement_timer:
	get: return movement_script.movement_timer
	set(v): movement_script.movement_timer = v

var wandering:
	get: return movement_script.wandering
	set(v): movement_script.wandering = v

var place_of_interest_spotted:
	get: return movement_script.place_of_interest_spotted
	set(v): movement_script.place_of_interest_spotted = v

var last_position:
	get: return movement_script.last_position
	set(v): movement_script.last_position = v

var is_moving:
	get: return movement_script.is_moving
	set(v): movement_script.is_moving = v

var movement_cooldown:
	get: return movement_script.movement_cooldown
	set(v): movement_script.movement_cooldown = v

var current_movement_timer:
	get: return movement_script.current_movement_timer
	set(v): movement_script.current_movement_timer = v

var has_moved_a_frame:
	get: return movement_script.has_moved_a_frame
	set(v): movement_script.has_moved_a_frame = v

var tween:
	get: return movement_script.tween
	set(v): movement_script.tween = v


func move_to_destination():
	movement_script.move_to_destination()
	
func update_pathfinding_grid():
	movement_script.update_pathfinding_grid()
	
func chase_character():
	movement_script.chase_character()
