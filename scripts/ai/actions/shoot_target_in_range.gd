class_name ShootTargetInRange
extends ActionLeaf


var can_attack = true


func tick(actor: Node, blackboard: Blackboard) -> int:
	if can_attack:
		
		var targets_in_range = []
		var can_attack = false
		
		for target in get_tree().get_nodes_in_group(blackboard.target_troop_group):
			if actor.global_position.distance_to(target.global_position) <= actor.stats.attack_range:
				targets_in_range.append(target)
		
		if targets_in_range.size() > 0:
			randomize()
			var selected_target = targets_in_range[randi_range(0, targets_in_range.size() - 1)]
			
			var projectile_inst = blackboard.projectile.instantiate()
			projectile_inst.global_position = actor.global_position
			projectile_inst.target_position = selected_target.global_position
			
			get_tree().get_first_node_in_group("ProjectileContainer").add_child(projectile_inst)
			
			actor.state_machine.set_state(TroopStateMachine.State.ATTACKING)
			start_cooldown(actor)
			
			if blackboard.sfx_list.has("attack"):
				blackboard.get_node(str(blackboard.sfx_list.attack)).play_sfx()
			
			return SUCCESS
	return FAILURE

func start_cooldown(actor: Node2D):
	can_attack = false
	await get_tree().create_timer(actor.stats.attack_cooldown).timeout
	can_attack = true
