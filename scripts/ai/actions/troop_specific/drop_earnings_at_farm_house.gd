extends MoveToLocation


func tick(actor: Node, blackboard: Blackboard) -> int:
	if not actor.get_node("NavigationAgent").is_connected("target_reached", _target_reached):
		actor.get_node("NavigationAgent").connect("target_reached", _target_reached)
	
	super(actor, blackboard)
	return SUCCESS

func _target_reached():
	if TimeCycle.is_daylight: GameStats.gold += GameStats.farm_level
	this_actor.get_node("NavigationAgent").disconnect("target_reached", _target_reached)
