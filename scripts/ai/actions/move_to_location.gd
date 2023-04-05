class_name MoveToLocation
extends ActionLeaf


@export var destination := Vector2.ZERO

var this_actor: Node


func tick(actor: Node, _blackboard: Blackboard) -> int:
	this_actor = actor
	actor.navigate_to(destination)
	return SUCCESS