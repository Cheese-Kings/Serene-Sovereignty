class_name IsDaylight
extends ConditionLeaf


@export var want_day := true


func tick(_actor: Node, _blackboard: Blackboard) -> int:
	if TimeCycle.is_daylight == want_day:
		return SUCCESS
	return FAILURE
