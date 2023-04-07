extends MoveToLocation



func tick(actor: Node, blackboard: Blackboard) -> int:
	if get_tree().get_nodes_in_group("EnemyTroop").size() <= 0:
		var actor_index = find_self(actor, blackboard)
		if actor_index != -1:
			var troop_division = 750 / get_tree().get_nodes_in_group(blackboard.troop_group).size()
			destination.x = (actor_index * troop_division) - 350
			destination.y = blackboard.ranged_attack_position_y
		
		return super(actor, blackboard)
	return SUCCESS

func find_self(actor: Node, blackboard: Blackboard) -> int:
	var troop_type_group = get_tree().get_nodes_in_group(blackboard.troop_group)
	var troop_index = 0
	for troop in troop_type_group:
		if troop == actor:
			return troop_index
		troop_index += 1
	
	return -1
