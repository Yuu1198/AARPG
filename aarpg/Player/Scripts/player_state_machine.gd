class_name PlayerStateMachine extends Node


var states : Array[State]
var prev_state : State
var current_state : State


# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_state(current_state.process(delta))
	pass


func _physics_process(delta):
	change_state(current_state.physics(delta))
	pass


func _unhandled_input(event):
	change_state(current_state.handle_input(event))
	pass


## Checks scenes tree if it has States and add to States array
func initialize(_player : Player) -> void:
	states = []
	
	# Append states in nodes to state array
	for c in get_children():
		if c is State:
			states.append(c)
	
	# For safety
	if states.size() == 0:
		return
	
	# Set first State
	states[0].player = _player
	states[0].state_machine = self
	
	# Initialize each state
	for state in states:
		state.init()
		
	change_state(states[0])
	process_mode = Node.PROCESS_MODE_INHERIT


func change_state(new_state : State) -> void:
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
