class_name TroopStateHandler
extends Node


@export var troop_animator: AnimationPlayer


func _state_idle():
	troop_animator.change_animation("RESET")

func _state_walking():
	troop_animator.change_animation("walk")

func _state_balls():
	troop_animator.change_animation("RESET")
