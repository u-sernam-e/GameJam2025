extends CharacterActivateable

signal activated

func activate():
	activated.emit()
