extends Troop


func _initialize_stats():
	stats = TroopStats.new().set_health(1).set_speed(35).set_attack_range(200).set_attack_cooldown(3).set_role(TroopStats.Role.Archer)
