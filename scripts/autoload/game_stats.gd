extends Node


var gold: int = 10000
var current_day: int = 1

var farm_level: int = 1
var farm_upgrade_cost: int = 100

var base_loser_cost: int = 10
var current_loser_cost: int = 100

var current_swordsman_cost: int = 10

var current_archer_cost: int = 20

var current_farmer_cost: int = 20


func _physics_process(_delta):
	var loser_count = get_tree().get_nodes_in_group("Troop").size()
	current_loser_cost = base_loser_cost * (loser_count * 0.3) + base_loser_cost
