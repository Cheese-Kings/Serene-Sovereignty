extends NavigationAgent2D


var base_avoidance_distance := 0

func _ready():
	base_avoidance_distance = radius

func _physics_process(_delta):
	if get_parent().visible:
		radius = base_avoidance_distance
	else:
		radius = 0
