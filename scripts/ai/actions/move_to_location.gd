class_name MoveToLocation
extends ActionLeaf


@export var destination := Vector2.ZERO

var target_reached = false


func tick(actor: Node, blackboard: Blackboard) -> int:
	if not actor.get_node("NavigationAgent").is_connected("target_reached", _target_reached):
		actor.get_node("NavigationAgent").connect("target_reached", _target_reached)
	
	actor.navigate_to(destination)
	
	if target_reached:
		target_reached = false
		actor.get_node("NavigationAgent").disconnect("target_reached", _target_reached)
		
		return SUCCESS
	
	return RUNNING

func _target_reached():
	target_reached = true
