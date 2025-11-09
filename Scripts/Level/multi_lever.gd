extends CharacterActivateable

@export var itemToActivate1 : BlockActivateable
@export var itemToActivate2 : BlockActivateable
@export var itemToActivate3 : BlockActivateable

@onready var onSprite = $On
@onready var offSprite = $Off

func activate():
	if itemToActivate1:
		itemToActivate1.activate()
	if itemToActivate2:
		itemToActivate2.activate()
	if itemToActivate3:
		itemToActivate3.activate()
	
	onSprite.visible = !onSprite.visible
	offSprite.visible = !offSprite.visible
