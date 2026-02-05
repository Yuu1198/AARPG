class_name EnemyStateMachine extends Node

var states : Array[EnemyState]
var prev_state : EnemyState
var current_state : EnemyState


func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_state(current_state.process(delta))
	pass


func _physics_process(delta):
	change_state(current_state.physics(delta))
	pass


func initialize(_enemy : Enemy) -> void:
	states = []
	
	# Build States array
	for c in get_children():
		if c is EnemyState:
			states.append(c)
	
	# Set up each State
	for s in states:
		s.enemy = _enemy
		s.state_machine = self
		s.init()
	
	# Get into first State
	if states.size() > 0:
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT


func change_state(new_state : EnemyState) -> void:
	# Abort if no new State
	if new_state == null || new_state == current_state:
		return
	
	# Exit current State
	if current_state:
		current_state.exit()
	
	# Enter new State
	prev_state = current_state
	current_state = new_state
	current_state.enter()
