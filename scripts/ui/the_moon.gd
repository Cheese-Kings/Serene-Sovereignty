extends TextureRect


func _process(_delta):
	if TimeCycle.current_time == TimeCycle.TimeState.Day: texture.region.position.x = 162
	elif TimeCycle.current_time == TimeCycle.TimeState.Night: texture.region.position.x = 0
	elif TimeCycle.current_time == TimeCycle.TimeState.Sunrise: texture.region.position.x = 108
	elif TimeCycle.current_time == TimeCycle.TimeState.Sunset: texture.region.position.x = 81
