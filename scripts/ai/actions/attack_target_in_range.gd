class_name AttackTargetInRange
extends ActionLeaf


var can_attack = true


func tick(actor: Node, blackboard: Blackboard) -> int:
	if can_attack:
		var targets_in_range = []
		var can_attack = false
		
		for target in get_tree().get_nodes_in_group(blackboard.target_troop_group):
			if actor.global_position.distance_to(target.global_position) <= actor.stats.attack_range + 5:
				targets_in_range.append(target)
		
		for target in targets_in_range:
			target.stats.health -= actor.stats.attack_power
			
			actor.state_machine.set_state(TroopStateMachine.State.ATTACKING)
			start_cooldown(actor)
	
		if targets_in_range.size() > 0:
			return SUCCESS
	
	return FAILURE

func start_cooldown(actor: Node2D):
	can_attack = false
	await get_tree().create_timer(actor.stats.attack_cooldown).timeout
	can_attack = true
