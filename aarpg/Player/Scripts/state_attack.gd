class_name State_Attack extends State

var attacking : bool = false

@export var attack_sound : AudioStream
@export_range(1, 20, 0.5) var decelerate_speed : float = 5.0

@onready var animation_player : AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_anim : AnimationPlayer = $"../../Sprite2D/AttackEffectsSprite/AnimationPlayer"
@onready var audio : AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

@onready var walk : State = $"../Walk"
@onready var idle = $"../Idle"
@onready var hurt_box : HurtBox = %AttackHurtBox


## What happens when the player enters this State?
func enter() -> void:
	# Animation
	player.update_animation("attack")
	attack_anim.play("attack_" + player.anim_direction())
	animation_player.animation_finished.connect(end_attack) # When animation finished, call EndAttack
	
	# Audio
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()
	
	attacking = true
	
	# Attack
	await get_tree().create_timer(0.075).timeout # Delay
	hurt_box.monitoring = true # Attack Collision on
	pass


## What happens when the player exits the State?
func exit() -> void:
	animation_player.animation_finished.disconnect(end_attack)
	attacking = false
	hurt_box.monitoring = false # Collision off
	pass


## What happens during the _process update in this State?
func process(_delta : float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta # Decrease walk speed over time
	
	if attacking == false:
		# When not moving go to Idle State else Walk
		if player.direction == Vector2.ZERO: 
			return idle
		else:
			return walk
	return null 


## What happens during the _physics_process update in this State?
func physics(_delta : float) -> State:
	return null


## What happens with input events in this State?
func handle_input(_event : InputEvent) -> State:
	return null


func end_attack(_nextAnimName : String) -> void:
	attacking = false
	pass
