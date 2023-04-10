extends Node2D


@onready var animation_player = $AnimationPlayer
@onready var alarm_timer = $AlarmTimer
@onready var day_music = $DayMusic
@onready var night_music = $NightMusic
@onready var alarm = $Alarm


func _ready():
	_on_day_night_cycle_time_changed(TimeCycle.current_time)

func _on_day_night_cycle_time_changed(time: int):
	if time == TimeCycle.TimeState.Day:
		animation_player.play("DayTransition")
		night_music.volume_db = -80
	if time == TimeCycle.TimeState.Sunset:
		animation_player.play_backwards("DayTransition")
		night_music.volume_db = -80
		alarm_timer.start()
	if time == TimeCycle.TimeState.Night:
		animation_player.play("NightTransition")
		day_music.volume_db = -80
	if time == TimeCycle.TimeState.Sunrise:
		animation_player.play_backwards("NightTransition")
		day_music.volume_db = -80

func _on_day_music_finished():
	day_music.play()

func _on_night_music_finished():
	night_music.play()

func _on_alarm_timer_timeout():
	alarm.play()
