class_name GoToRandomArea
extends ActionLeaf


@export var move_range: Vector2
@export var arrive_sfx: String

var target_reached = false


func tick(actor: Node, blackboard: Blackboard) -> int:
	if not actor.get_node("NavigationAgent").is_connected("target_reached", _target_reached):
		actor.get_node("NavigationAgent").connect("target_reached", _target_reached)
	
	if target_reached:
		target_reached = false
		actor.get_node("NavigationAgent").disconnect("target_reached", _target_reached)
		
		if arrive_sfx != null:
			if blackboard.sfx_list.has(arrive_sfx):
				blackboard.get_node(str(blackboard.sfx_list.get(arrive_sfx))).play_sfx()
		
		return SUCCESS
	
	if not actor.navigating:
		actor.navigate_to(Vector2(randi_range(-move_range.x, move_range.x), randi_range(-move_range.y + 20, move_range.y)))
	
	return FAILURE

func _target_reached():
	target_reached = true
