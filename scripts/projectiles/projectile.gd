extends Area2D


@export var attack_power := 0
@export var move_speed := 0

var target_position = Vector2.ZERO
var can_move = true


func _physics_process(delta):
	if can_move:
		look_at(target_position)
		global_position += global_position.direction_to(target_position) * move_speed * delta
	
	if global_position.distance_to(target_position) < (move_speed / 4):
		can_move = false
		_reached_target()

func _reached_target():
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("EnemyTroop"):
		body.stats.health -= attack_power
		queue_free()