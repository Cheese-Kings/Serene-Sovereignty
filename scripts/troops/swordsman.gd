extends Troop


func _initialize_stats():
	stats = TroopStats.new().set_health(1).set_speed(25).set_role(TroopStats.Role.Swordsman)
