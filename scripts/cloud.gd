extends Node2D


const SPEED = 20

var cloud_1 = preload("res://assets/sprites/clouds/cloud1.png")
var cloud_2 = preload("res://assets/sprites/clouds/cloud2.png")
var cloud_3 = preload("res://assets/sprites/clouds/cloud3.png")
var cloud_4 = preload("res://assets/sprites/clouds/cloud4.png")

@onready var sprite = $Sprite


func _ready():
	randomize()
	var cloud_option = randi_range(1, 4)
	
	if cloud_option == 1: sprite.set_texture(cloud_1)
	elif cloud_option == 2: sprite.set_texture(cloud_2)
	elif cloud_option == 3: sprite.set_texture(cloud_3)
	elif cloud_option == 4: sprite.set_texture(cloud_4)

func _physics_process(delta):
	if global_position.x >= 450:
		queue_free()
	
	global_position.x += SPEED * delta
