extends PointLight2D


func _physics_process(_delta):
	if TimeCycle.is_daylight: enabled = false
	else: enabled = true
