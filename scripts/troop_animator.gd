extends AnimationPlayer


var can_change_animation = true


func _ready():
	play("troops/spawn")

func change_animation(new_animation: String):
	if can_change_animation:
		if current_animation != new_animation:
			stop()
			play(new_animation)

func _on_animation_finished(anim_name):
	if anim_name == "troops/spawn":
		can_change_animation = true
