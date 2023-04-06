class_name GoToNearestTarget
extends ActionLeaf


var target_reached = false
var target_troop: Node2D


func tick(actor: Node, blackboard: Blackboard) -> int:
	if not actor.get_node("NavigationAgent").is_connected("target_reached", _target_reached):
		actor.get_node("NavigationAgent").connect("target_reached", _target_reached)
	
	if target_reached:
		target_reached = false
		target_troop = null
		actor.get_node("NavigationAgent").disconnect("target_reached", _target_reached)
		
		return SUCCESS
	elif target_troop != null:
		actor.navigate_to(target_troop.position)
	
	if target_troop == null:
		target_troop = find_closest_troop(actor, blackboard)
		
		if target_troop == null:
			return FAILURE
		
		actor.navigate_to(target_troop.position)
	
	return RUNNING

func _target_reached():
	target_reached = true

func find_closest_troop(actor: Node2D, blackboard: Blackboard) -> Node2D:
	var closest_distance = 99999999
	var closest_troop: Node2D = null
	
	for troop in get_tree().get_nodes_in_group(blackboard.target_troop_group):
		var troop_distance = actor.global_position.distance_to(troop.global_position)
		
		if troop_distance < closest_distance:
			closest_distance = troop_distance
			closest_troop = troop
	
	return closest_troop
