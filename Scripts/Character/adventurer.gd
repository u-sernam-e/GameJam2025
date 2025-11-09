extends BaseCharacter

@export var player_node: Node2D
@export var character_type: String

@onready var sprite_2d = $Sprite2D
@onready var activate_collision = $ActivateCollision
@onready var coin_collision = $CoinCollision
@onready var hurtbox = $Hurtbox

var inCrateAnimation : bool = false
var onCrate : bool = false
var mountedCrate : Node2D

const TILE_SIZE = 16

var attack_speed: float

func _ready():
	sprite_2d.play("idle")
	player_node.player_did_an_action.connect(_move_to_mouse)
	hurtbox.body_entered.connect(_death_body_entered)
	hurtbox.area_entered.connect(_death_area_entered)
	Globals.updateTileMap.connect(_updateTileMap)

func _process(_delta: float) -> void:
	if onCrate:
		global_position = mountedCrate.global_position
	if Globals.change_screen:
		global_position = global_position - Vector2(48, 0)
		Globals.updateTileMap.emit()
		move_to_destination()
		Globals.change_screen = false
	if Globals.activate_death:
		die()
		
func _move_to_mouse():
	if onCrate and mountedCrate.isMoving:
		return
	onCrate = false
	is_moving_to_destination = true
	destination_position = (get_global_mouse_position() / movement_script.TILE_SIZE).floor()
	sprite_2d.play("walk")
	move_to_destination()

func _updateTileMap():
	call_deferred("update_pathfinding_grid")

func do_action():
	if onCrate:
		return
	for b in activate_collision.get_overlapping_areas():
		if b is CharacterActivateable:
			b.activate()

func die():
	Globals.activate_death = true
	sprite_2d.play("death")
	await sprite_2d.animation_finished
	get_tree().reload_current_scene()
	queue_free()

func _death_body_entered(_body : Node2D):
	die()
func _death_area_entered(_body : Node2D):
	die()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("RightClick"):
		do_action()

func mountCrate(crate : Node2D):
	inCrateAnimation = true
	mountedCrate = crate
	var crate_tween = create_tween()
	crate_tween.finished.connect(_crate_animation_tween_finished)
	crate_tween.set_ease(Tween.EASE_OUT)
	crate_tween.set_trans(Tween.TRANS_SINE)
	crate_tween.tween_property(self, "position", crate.global_position, 0.5)

func _crate_animation_tween_finished():
	onCrate = true
	inCrateAnimation = false
