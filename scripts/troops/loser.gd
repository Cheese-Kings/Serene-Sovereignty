extends Troop


func _initialize_stats():
	stats = TroopStats.new().set_health(5).set_speed(20).set_role(TroopStats.Role.Loser)
