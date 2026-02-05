class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
var direction : Vector2 = Vector2.ZERO

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : PlayerStateMachine = $StateMachine

signal direction_changed(new_direction : Vector2)


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerManager.player = self
	state_machine.initialize(self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Calculate direction
	#direction.x = Input.get_action_strength("right") - Input.get_action_strength("left") # right is 1, left is -1, right+left is 0
	#direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()
	
	pass


func _physics_process(delta):
	move_and_slide()


func set_direction() -> bool:
	if direction == Vector2.ZERO: # no new direction
		return false
	
	# Calculate New Direction
	var direction_id : int = int(round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size())) # 0-3 based on Direction, prefers facing of first direction when walking diagonally
	var new_direction = DIR_4[direction_id] # Sets New Direction based on index of Direction ID
	
	if new_direction == cardinal_direction:
		return false
	
	cardinal_direction = new_direction
	direction_changed.emit(new_direction)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1 # flip sprite
	return true 


func update_animation(state : String) -> void:
	animation_player.play(state + "_" + anim_direction())
	pass


func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
