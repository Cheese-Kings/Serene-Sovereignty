class_name IsCertainTime
extends ConditionLeaf


@export var required_time: TimeCycle.TimeState


func tick(_actor: Node, _blackboard: Blackboard) -> int:
	if TimeCycle.current_time == required_time:
		return SUCCESS
	return FAILURE
