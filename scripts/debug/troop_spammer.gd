extends Node2D


@export var troop_counter: Label
@export var spawn_timer: Timer
@export var troop_container: Node2D

var troop = preload("res://scenes/troops/loser.tscn")

var spawned_troops = 0


func _process(_delta):
	troop_counter.text = "Spawned Troops: " + str(spawned_troops)

func _on_timer_timeout():
	var troop_instance = troop.instantiate()
	troop_instance.position.y = -100
	troop_container.add_child(troop_instance)
	
	spawned_troops += 1
