class_name CloudSpawner
extends Node2D


@export var spawn_timer: Timer

var cloud = preload("res://scenes/cloud.tscn")


func _ready():
	spawn_timer.connect("timeout", spawn_cloud)

func _process(_delta):
	if SettingValues.enable_clouds: show()
	else: hide()

func spawn_cloud():
	if SettingValues.enable_clouds:
		var cloud_inst = cloud.instantiate()
		
		randomize()
		cloud_inst.position.y = randi_range(-150, 100)
		
		add_child(cloud_inst)
		
		randomize()
		spawn_timer.wait_time = randi_range(10, 20)
