extends TileMapLayer

# this is made for crate to use
func stringToRadians(dir : String) -> float:
	if dir == "up":
		return 0
	if dir == "right":
		return PI/2
	if dir == "down":
		return PI
	if dir == "left":
		return (3*PI)/2
	printerr("Water.stringToRadians() inputted invalid direction string")
	return 0
