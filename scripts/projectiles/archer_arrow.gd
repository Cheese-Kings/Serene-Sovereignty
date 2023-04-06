extends "res://scripts/projectiles/projectile.gd"


@onready var sprite = $Sprite

var landed_texture = preload("res://assets/sprites/projectiles/noheadarrow.png")


func _process(_delta):
	if TimeCycle.current_time == TimeCycle.TimeState.Day and not can_move:
		queue_free()

func _reached_target():
	rotation = 90
	sprite.set_texture(landed_texture)
