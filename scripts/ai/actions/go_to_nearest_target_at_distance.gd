class_name GoToNearestTargetAtDistance
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
		navigate_to_troop(actor)
	
	if target_troop == null:
		target_troop = find_closest_troop(actor, blackboard)
		
		if target_troop == null:
			return FAILURE
		
		navigate_to_troop(actor)
	
	return RUNNING

func _target_reached():
	target_reached = true

func navigate_to_troop(actor: Node2D):
	if actor.global_position.distance_to(target_troop.global_position) <= (actor.stats.attack_range - 50):
		actor.navigating = false
		target_reached = true
	else:
		actor.navigate_to(target_troop.global_position)

func find_closest_troop(actor: Node2D, blackboard: Blackboard) -> Node2D:
	var closest_distance = 99999999
	var closest_troop: Node2D = null
	
	for troop in get_tree().get_nodes_in_group(blackboard.target_troop_group):
		var troop_distance = actor.global_position.distance_to(troop.global_position)
		
		if troop_distance < closest_distance:
			closest_distance = troop_distance
			closest_troop = troop
	
	return closest_troop
