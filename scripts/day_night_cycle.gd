extends Node2D


@onready var canvas_modulate = $CanvasModulate
@onready var animation_player = $AnimationPlayer
@onready var day_night_timer = $DayNightTimer
@onready var sunset_sunrise_timer = $SunsetSunriseTimer


func _ready():
	animation_player.play("Sunset")
	
	if TimeCycle.current_time == TimeCycle.TimeState.Day:
		day_night_timer.start()
		TimeCycle.is_daylight = true
	elif TimeCycle.current_time == TimeCycle.TimeState.Night:
		day_night_timer.start()
		TimeCycle.is_daylight = false
	if TimeCycle.current_time == TimeCycle.TimeState.Sunrise:
		sunset_sunrise_timer.start()
		TimeCycle.is_daylight = true
	elif TimeCycle.current_time == TimeCycle.TimeState.Sunset:
		sunset_sunrise_timer.start()
		TimeCycle.is_daylight = false

func _physics_process(_delta):
	if TimeCycle.current_time == TimeCycle.TimeState.Night:
		if get_tree().get_nodes_in_group("EnemyTroop").size() <= 0:
			_on_day_night_timer_timeout()

func _on_day_night_timer_timeout():
	if TimeCycle.current_time == TimeCycle.TimeState.Day:
		TimeCycle.current_time = TimeCycle.TimeState.Sunset
		TimeCycle.is_daylight = false
		animation_player.play("Sunset")
	elif TimeCycle.current_time == TimeCycle.TimeState.Night:
		TimeCycle.current_time = TimeCycle.TimeState.Sunrise
		TimeCycle.is_daylight = true
		animation_player.play("Sunrise")
		GameStats.current_day += 1
	sunset_sunrise_timer.start()

func _on_sunset_sunrise_timer_timeout():
	if TimeCycle.current_time == TimeCycle.TimeState.Sunset:
		TimeCycle.current_time = TimeCycle.TimeState.Night
		animation_player.play("Night")
		TimeCycle.emit_signal("turned_night")
		
	elif TimeCycle.current_time == TimeCycle.TimeState.Sunrise:
		TimeCycle.current_time = TimeCycle.TimeState.Day;
		animation_player.play("Day")
		day_night_timer.start()
