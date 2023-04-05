extends Node2D


func _on_town_hall_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("Troop") and not body.is_in_group("Loser"):
		body.hide()
		body.get_node("Collider").set_deferred("disabled", true)

func _on_town_hall_area_exited(area):
	var body = area.get_parent()
	if body.is_in_group("Troop") and not body.is_in_group("Loser"):
		body.show()
		body.get_node("Collider").set_deferred("disabled", false)
