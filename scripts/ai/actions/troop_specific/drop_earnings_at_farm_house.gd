extends MoveToLocation


func _target_reached():
	if TimeCycle.is_daylight:
		GameStats.gold += GameStats.farm_level
		GameStats.total_gold_earned += GameStats.farm_level
	target_reached = true
