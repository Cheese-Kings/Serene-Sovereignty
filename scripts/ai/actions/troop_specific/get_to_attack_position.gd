extends MoveToLocation



func _physics_process(_delta):
	if this_blackboard == null:
		return
	
	var actor_index = find_self()
	if actor_index != -1:
		var troop_division = 750 / get_tree().get_nodes_in_group(this_blackboard.troop_group).size()
		destination.x = (actor_index * troop_division) - 350

func find_self() -> int:
	var troop_type_group = get_tree().get_nodes_in_group(this_blackboard.troop_group)
	var troop_index = 0
	for troop in troop_type_group:
		if troop == this_actor:
			return troop_index
		troop_index += 1
	
	return -1
