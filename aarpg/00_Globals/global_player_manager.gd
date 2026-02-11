extends Node


const PLAYER = preload("uid://b4sse476kdci4")

var player : Player
var player_spawned : bool = false


func _ready() -> void:
	add_player_instance()
	await get_tree().create_timer(0.2).timeout
	player_spawned = true


func add_player_instance() -> void:
	player = PLAYER.instantiate()
	add_child(player)
	pass


func set_player_position(_new_pos : Vector2) -> void:
	player.global_position = _new_pos
	pass


func set_as_parent(_p : Node2D) -> void:
	# Remove Player from current parent
	if player.get_parent():
		player.get_parent().remove_child(player)
	# Add Player to new parent
	_p.add_child(player)
	pass


func unparent_player(_p : Node2D) -> void:
	_p.remove_child(player)
	pass
