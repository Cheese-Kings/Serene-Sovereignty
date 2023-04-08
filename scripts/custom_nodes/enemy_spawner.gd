class_name EnemySpawner
extends Node2D


const SWORDSMAN_CAP = 40
const ARCHER_CAP = 30
const SHIELDMAM_CAP = 15
const WIZARD_CAP = 20

var swordsman = preload("res://scenes/enemy_troops/evil_swordsman.tscn")
var archer = preload("res://scenes/enemy_troops/evil_archer.tscn")
var shieldman = preload("res://scenes/enemy_troops/evil_shieldman.tscn")
var wizard = preload("res://scenes/enemy_troops/evil_wizard.tscn")

var troops_to_spawn = []


func _ready():
	TimeCycle.connect("turned_night", spawn_troops)

func spawn_troops():
	troops_to_spawn.clear()
	var day_count = GameStats.current_day
	var troop_container = get_tree().get_first_node_in_group("TroopContainer")
	
	if day_count >= 2:
		var swordsman_count = floor(day_count / 1.3)
		#if swordsman_count > SWORDSMAN_CAP: swordsman_count = SWORDSMAN_CAP
		for num in range(swordsman_count):
			troops_to_spawn.append(swordsman.instantiate())
	
	if day_count >= 10:
		var archer_count = -4 + floor(day_count / 1.8)
		#if archer_count > ARCHER_CAP: archer_count = ARCHER_CAP
		for num in range(archer_count):
			troops_to_spawn.append(archer.instantiate())
	
	if day_count >= 20:
		var shieldman_count = -10 + floor(day_count / 1.7)
		#if shieldman_count > SHIELDMAM_CAP: shieldman_count = SHIELDMAM_CAP
		for num in range(shieldman_count):
			troops_to_spawn.append(shieldman.instantiate())
	
	if day_count >= 30:
		var wizard_count = -14 + floor(day_count / 2)
		#if wizard_count > WIZARD_CAP: wizard_count = WIZARD_CAP
		for num in range(wizard_count):
			troops_to_spawn.append(wizard.instantiate())
	
	
	for troop in troops_to_spawn:
		randomize()
		troop.position.x = randi_range(-300, 300)
		troop.position.y = -184
		troop_container.add_child(troop)
