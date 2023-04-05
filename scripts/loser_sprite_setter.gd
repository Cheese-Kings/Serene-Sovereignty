extends Sprite2D


var female_sprite = preload("res://assets/sprites/troops/neutralunitfemale.png")


func _ready():
	randomize()
	var gender_chance = randi_range(0, 1)
	if gender_chance == 1:
		texture = female_sprite
