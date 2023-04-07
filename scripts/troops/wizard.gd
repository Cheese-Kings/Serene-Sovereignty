extends Troop


func _initialize_stats():
	stats = TroopStats.new().set_health(3).set_speed(55).set_attack_range(300).set_attack_cooldown(5).set_role(TroopStats.Role.Wizard)
