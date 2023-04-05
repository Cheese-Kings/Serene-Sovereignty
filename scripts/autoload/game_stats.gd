extends Node


var gold: int = 10000
var current_day: int = 1

var farm_level: int = 1
var farm_upgrade_cost: int = 100

var base_loser_cost: int = 100
var current_loser_cost: int = 100

var base_swordsman_cost: int = 100
var current_swordsman_cost: int = 100


func _physics_process(_delta):
	var swordsmen_count = get_tree().get_nodes_in_group("Swordsman").size()
	current_swordsman_cost = base_swordsman_cost * (swordsmen_count * 0.2)
