class_name LevelTileMap extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	LevelManager.change_tilemap_bounds(get_tilemap_bounds()) # Change Bounds in Level Manager to Tilemap Bounds of this Level
	pass # Replace with function body.


func get_tilemap_bounds() -> Array[Vector2]:
	var bounds : Array[Vector2] = []
	bounds.append(
		Vector2(get_used_rect().position * rendering_quadrant_size) # Top left corner
	)
	bounds.append(
		Vector2(get_used_rect().end * rendering_quadrant_size) # Bottom right corner
	)
	return bounds
