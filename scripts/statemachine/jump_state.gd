extends AbilityState
class_name JumpState

@export var jump_strength = 7.0

var jump_single = true
var jump_double = true

func enter() -> void:
	if player.is_on_floor():
		player.gravity = -jump_strength
		player.model.scale = Vector3(0.5, 1.5, 0.5)
		jump_single = false
		jump_double = true
		Audio.play("res://sounds/jump.ogg")
	elif jump_double:
		player.gravity = -jump_strength
		player.model.scale = Vector3(0.5, 1.5, 0.5)
		jump_double = false
		Audio.play("res://sounds/jump.ogg")


func physics_process(delta: float) -> void:
	if player.is_on_floor():
		jump_single = true
		player.gravity = 0
		# activate state machine in player to transition to exit this state
		player.state_machine.transition_to("IdleState")

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		if player.is_on_floor() or player.jump_double:
			enter()