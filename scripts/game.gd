extends Node2D


var enable_losing = false


func _ready():
	SaveSystem.load_game()

func _physics_process(_delta):
	if get_tree().get_nodes_in_group("Troop").size() <= 0 and enable_losing:
		you_lose()

func you_lose():
	DirAccess.remove_absolute("user://save_data")
	get_tree().get_first_node_in_group("LoseScreen").show()

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
