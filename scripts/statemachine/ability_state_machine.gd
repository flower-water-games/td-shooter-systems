extends Node
class_name AbilityStateMachine

var current_state: AbilityState
var _player : Player
var _states : Dictionary = {}



func _init(player : Player, states:Dictionary) -> void:
	_player = player
	_states = states


func _ready():
	for state in _states.values():
		state.player = _player

	if _states.size() > 0:
		current_state = _states.values()[0]
		current_state.enter()

func _process(delta):
	current_state.update(delta)

func _input(event : InputEvent):
	current_state.handle_input(event)

func change_state(state_name : String):
	if _states.has(state_name):
		current_state.exit()
		current_state = _states[state_name]
		current_state.enter()
	else:
		printerr("State not found: " + state_name)