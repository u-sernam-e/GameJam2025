extends BlockActivateable

@onready var arrow: PackedScene = preload("res://Scenes/Level/arrrow.tscn")
var arrow_instantiated = false
@export var dir: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func activate():
	_instantiate_arrow()

func _instantiate_arrow():
	var arrow_clone = arrow.instantiate()
	arrow_clone.dir = dir
	arrow_clone.global_position = global_position
	get_tree().current_scene.add_child(arrow_clone)
	arrow_instantiated = true
