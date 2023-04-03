class_name Troop
extends CharacterBody2D


@export var nav_agent: NavigationAgent2D

var stats: TroopStats

var navigating = false


func _ready():
	# Initialize troop stats
	_initialize_stats()
	
	nav_agent.velocity_computed.connect(_on_velocity_computed)
	nav_agent.target_reached.connect(_on_target_reached)

func _physics_process(_delta):
	if navigating:
		var next_location = nav_agent.get_next_path_position()
		var v = (next_location - global_position).normalized() * stats.speed
		nav_agent.set_velocity(v)
		
		$PathLine.points[0] = global_position - position
		$PathLine.points[1] = next_location - position
	

# Function to initialize troop stats
func _initialize_stats():
	stats = TroopStats.new()

func navigate_to(location: Vector2):
	nav_agent.target_position = location
	navigating = true

func _on_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity
	move_and_slide()
	#position += safe_velocity

func _on_target_reached():
	navigating = false
