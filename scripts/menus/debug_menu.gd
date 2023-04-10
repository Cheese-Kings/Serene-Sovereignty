extends Control


@onready var fps_counter = $DebugTexts/FPS
@onready var msf_counter = $DebugTexts/MSF
@onready var troop_count = $DebugTexts/TroopCount
@onready var cloud_count = $DebugTexts/CloudCount


var frames = 0
var time_passed = 0.0


func _process(delta):
	msf_counter.text = "ms/f: " + str(delta)
	troop_count.text = "Troop Count: " + str(get_tree().get_nodes_in_group("Troop").size() + get_tree().get_nodes_in_group("EnemyTroop").size())
	cloud_count.text = "Cloud Count: " + str(get_tree().get_nodes_in_group("Cloud").size())
	
	time_passed += delta
	frames += 1
	
	if time_passed >= 1:
		time_passed -= 1
		fps_counter.text = "FPS: " + str(frames)
		frames = 0

func _input(event):
	if event.is_action_pressed("toggle_debug"):
		visible = not visible
