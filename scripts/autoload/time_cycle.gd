extends Node


enum TimeState {
	Day,
	Sunset,
	Night,
	Sunrise
}


var current_time := TimeState.Sunset
var is_daylight = false
