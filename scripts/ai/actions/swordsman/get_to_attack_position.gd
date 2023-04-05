extends MoveToLocation


func _physics_process(_delta):
	var actor_index = find_self()
	if actor_index != -1:
		var swordsmen_division = 750 / get_tree().get_nodes_in_group("Swordsman").size()
		destination.x = (actor_index * swordsmen_division) - 330
		#print(destination.x)

func find_self() -> int:
	var swordsmen = get_tree().get_nodes_in_group("Swordsman")
	var troop_index = 0
	for troop in swordsmen:
		if troop == this_actor:
			return troop_index
		troop_index += 1
	
	return -1
