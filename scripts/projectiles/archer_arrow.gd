extends "res://scripts/projectiles/projectile.gd"


@export var landed_texture = preload("res://assets/sprites/projectiles/noheadarrow.png")

@onready var sprite = $Sprite
@onready var collider = $Collider
@onready var land_sound = $LandSound


func _process(_delta):
	if TimeCycle.current_time == TimeCycle.TimeState.Day and not can_move:
		queue_free()

func _reached_target():
	rotation = 90
	collider.set_deferred("disabled", true)
	sprite.set_texture(landed_texture)

func _hit_troop():
	pass
	#land_sound.play_sfx()
