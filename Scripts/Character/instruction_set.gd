extends Node

var nextId : int = 0
var totalIds : int = 0

@export var character : BaseCharacter

func createInstruction() -> void:
	var instruct  = BaseInstruction.new()
	add_child(instruct)
	instruct.id = totalIds
	totalIds += 1

func doNextInstruction():
	for instruct in get_children():
		if instruct is BaseInstruction and instruct.id == nextId:
			instruct.doInstruction()
			nextId += 1
			break
