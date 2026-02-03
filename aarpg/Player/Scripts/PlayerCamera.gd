class_name PlayerCamera extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	LevelManager.TileMapBoundsChanged.connect(UpdateLimits) # Update Camera Bounds to Bounds of current Level
	UpdateLimits(LevelManager.current_tilemap_bounds) # For first time
	pass # Replace with function body.


# Set Limits of Camera to Bounds
func UpdateLimits(bounds : Array[Vector2]) -> void:
	if bounds == []:
		return
	limit_left = int(bounds[0].x)
	limit_top = int(bounds[0].y)
	limit_right = int(bounds[1].x)
	limit_bottom = int(bounds[1].y)
	pass
