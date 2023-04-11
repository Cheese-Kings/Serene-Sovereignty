extends Node2D


var enable_losing = false

@onready var days_survived = $UILayer/UI/LoseScreen/DaysSurvived
@onready var enemies_defeated = $UILayer/UI/LoseScreen/EnemiesDefeated
@onready var total_gold_earned = $UILayer/UI/LoseScreen/TotalGoldEarned


func _ready():
	SaveSystem.load_game()

func _physics_process(_delta):
	if get_tree().get_nodes_in_group("Troop").size() <= 0 and enable_losing:
		you_lose()

func you_lose():
	SaveSystem.delete_save_data()
	
	days_survived.text = "Days survived: " + str(GameStats.current_day)
	enemies_defeated.text = "Enemies defeated: " + str(GameStats.enemies_killed)
	total_gold_earned.text = "Total gold earned: " + str(GameStats.total_gold_earned)
	
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

func _on_return_to_menu_after_lose_button_pressed():
	ArcLoader.change_scene("res://scenes/main_menu.tscn")
