extends Node2D


signal time_changed


@onready var canvas_modulate = $CanvasModulate
@onready var animation_player = $AnimationPlayer
@onready var day_night_timer = $DayNightTimer
@onready var sunset_sunrise_timer = $SunsetSunriseTimer


func _ready():
	if TimeCycle.current_time == TimeCycle.TimeState.Day:
		day_night_timer.start()
		TimeCycle.is_daylight = true
		#emit_signal("time_changed", TimeCycle.TimeState.Day)
	elif TimeCycle.current_time == TimeCycle.TimeState.Night:
		day_night_timer.start()
		TimeCycle.is_daylight = false
		#emit_signal("time_changed", TimeCycle.TimeState.Night)
	if TimeCycle.current_time == TimeCycle.TimeState.Sunrise:
		sunset_sunrise_timer.start()
		TimeCycle.is_daylight = true
		#emit_signal("time_changed", TimeCycle.TimeState.Sunrise)
	elif TimeCycle.current_time == TimeCycle.TimeState.Sunset:
		sunset_sunrise_timer.start()
		TimeCycle.is_daylight = false
		#emit_signal("time_changed", TimeCycle.TimeState.Sunset)

func _physics_process(_delta):
	if TimeCycle.current_time == TimeCycle.TimeState.Night:
		if get_tree().get_nodes_in_group("EnemyTroop").size() <= 0:
			_on_day_night_timer_timeout()

func _on_day_night_timer_timeout():
	if TimeCycle.current_time == TimeCycle.TimeState.Day:
		TimeCycle.current_time = TimeCycle.TimeState.Sunset
		TimeCycle.is_daylight = false
		animation_player.play("Sunset")
		emit_signal("time_changed", TimeCycle.TimeState.Sunset)
	elif TimeCycle.current_time == TimeCycle.TimeState.Night:
		SaveSystem.save_game()
		TimeCycle.current_time = TimeCycle.TimeState.Sunrise
		TimeCycle.is_daylight = true
		animation_player.play("Sunrise")
		GameStats.current_day += 1
		emit_signal("time_changed", TimeCycle.TimeState.Sunrise)
	sunset_sunrise_timer.start()

func _on_sunset_sunrise_timer_timeout():
	if TimeCycle.current_time == TimeCycle.TimeState.Sunset:
		TimeCycle.current_time = TimeCycle.TimeState.Night
		animation_player.play("Night")
		TimeCycle.emit_signal("turned_night")
		emit_signal("time_changed", TimeCycle.TimeState.Night)
	elif TimeCycle.current_time == TimeCycle.TimeState.Sunrise:
		TimeCycle.current_time = TimeCycle.TimeState.Day;
		animation_player.play("Day")
		day_night_timer.start()
		emit_signal("time_changed", TimeCycle.TimeState.Day)
