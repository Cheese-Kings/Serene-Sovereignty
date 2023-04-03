extends ActionLeaf


@export var move_chance_max := 10
@export var move_distance := 50


func tick(actor, blackboard):
	randomize()
	var move_chance = randi_range(0, move_chance_max)
	
	if move_chance == 0:
		randomize()
		actor.navigate_to(Vector2(randf_range(-move_distance, move_distance), randf_range(-move_distance, move_distance)))
	
	return SUCCESS
