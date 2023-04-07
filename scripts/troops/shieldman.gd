extends Troop


func _initialize_stats():
	stats = TroopStats.new().set_health(10).set_speed(30).set_role(TroopStats.Role.Shieldman)
