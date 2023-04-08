class_name TroopStateHandler
extends Node


@export var troop_animator: AnimationPlayer


func _state_idle():
	troop_animator.change_animation("troops/idle")

func _state_walking():
	troop_animator.change_animation("troops/walk")

func _state_attacking():
	troop_animator.change_animation("troops/attack")

func _state_balls():
	troop_animator.change_animation("troops/idle")

func _on_troop_animation_finished(anim_name):
	if anim_name == "troops/attack":
		get_parent().state_machine.set_state(TroopStateMachine.State.IDLE)
