extends AnimationPlayer


func change_animation(new_animation: String):
	if current_animation != new_animation:
		stop()
		play(new_animation)
