class_name MoveToLocation
extends ActionLeaf


@export var destination := Vector2.ZERO
@export var arrive_sfx: String

var target_reached = false


func tick(actor: Node, blackboard: Blackboard) -> int:
	if not actor.get_node("NavigationAgent").is_connected("target_reached", _target_reached):
		actor.get_node("NavigationAgent").connect("target_reached", _target_reached)
	
	actor.navigate_to(destination)
	
	if target_reached:
		target_reached = false
		actor.get_node("NavigationAgent").disconnect("target_reached", _target_reached)
		
		if arrive_sfx != null:
			if blackboard.sfx_list.has(arrive_sfx):
				blackboard.get_node(str(blackboard.sfx_list.get(arrive_sfx))).play_sfx()
		
		return SUCCESS
	
	return RUNNING

func _target_reached():
	target_reached = true
