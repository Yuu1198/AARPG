extends Node2D



func _ready():
	visible = false # Dont see it while playing
	if PlayerManager.player_spawned == false:
		# Spawn Player
		PlayerManager.set_player_position(global_position)
		PlayerManager.player_spawned = true
