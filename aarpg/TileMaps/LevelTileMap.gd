class_name LevelTileMap extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	LevelManager.ChangeTilemapBounds(GetTilemapBounds()) # Change Bounds in Level Manager to Tilemap Bounds of this Level
	pass # Replace with function body.


func GetTilemapBounds() -> Array[Vector2]:
	var bounds : Array[Vector2] = []
	bounds.append(
		Vector2(get_used_rect().position * rendering_quadrant_size) # Top left corner
	)
	bounds.append(
		Vector2(get_used_rect().end * rendering_quadrant_size) # Bottom right corner
	)
	return bounds
