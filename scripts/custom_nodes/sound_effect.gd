class_name SoundEffect
extends AudioStreamPlayer2D


var origional_pitch = 1


func _ready():
	origional_pitch = pitch_scale

func play_sfx():
	randomize()
	pitch_scale = pitch_scale + randf_range(-0.2, 0.2)
	play()

func _on_finished():
	pitch_scale = origional_pitch
