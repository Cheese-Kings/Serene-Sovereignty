class_name TroopStateMachine
extends Resource


enum State {
	IDLE,
	WALKING,
	ATTACKING,
	BALLS
}


var state: State : set = set_state, get = get_state


func set_state(new_state: State) -> TroopStateMachine:
	state = new_state
	return self

func get_state() -> State:
	return state
