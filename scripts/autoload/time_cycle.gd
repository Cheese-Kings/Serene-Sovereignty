extends Node


signal turned_night

enum TimeState {
	Day,
	Sunset,
	Night,
	Sunrise
}


var current_time := TimeState.Day
var is_daylight = true
