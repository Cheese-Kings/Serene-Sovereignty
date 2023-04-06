extends Troop


func _initialize_stats():
	stats = TroopStats.new().set_health(2).set_speed(35).set_attack_range(20).set_attack_power(1).set_attack_cooldown(1).set_role(TroopStats.Role.Swordsman)
