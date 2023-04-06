class_name MoveToLocation
extends ActionLeaf


@export var destination := Vector2.ZERO

var this_actor: Node
var this_blackboard: Blackboard


func tick(actor: Node, blackboard: Blackboard) -> int:
	this_actor = actor
	this_blackboard = blackboard
	
	actor.navigate_to(destination)
	return SUCCESS
