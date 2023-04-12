extends Node


var gold: int = 100
var total_gold_earned: int = 0

var current_day: int = 1
var enemies_killed: int = 0

var farm_level: int = 1
var farm_upgrade_cost: int = 100

var base_loser_cost: int = 10
var current_loser_cost: int = 0

var current_swordsman_cost: int = 100

var current_archer_cost: int = 300

var current_farmer_cost: int = 500

var current_wizard_cost: int = 2000

var current_shieldman_cost: int = 400


func _physics_process(_delta):
	var loser_count = get_tree().get_nodes_in_group("Troop").size()
	current_loser_cost = base_loser_cost * (loser_count * 0.4) + base_loser_cost
