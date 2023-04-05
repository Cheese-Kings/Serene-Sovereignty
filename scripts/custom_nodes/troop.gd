class_name Troop
extends CharacterBody2D


@export var nav_agent: NavigationAgent2D
@export var troop_animator: AnimationPlayer
@export var state_handler: TroopStateHandler

const VEL_LIMIT = 0.2

var stats: TroopStats
var state_machine: TroopStateMachine

var navigating = false

var old_pos := Vector2.ZERO


func _ready():
	_initialize_state_machine()
	
	# Initialize troop stats
	_initialize_stats()
	
	troop_animator.speed_scale = stats.speed / 10
	
	nav_agent.velocity_computed.connect(_on_velocity_computed)
	nav_agent.target_reached.connect(_on_target_reached)

func _physics_process(_delta):
	if navigating:
		var next_location = nav_agent.get_next_path_position()
		var v = (next_location - global_position).normalized() * stats.speed
		nav_agent.set_velocity(v)
		
		if OS.is_debug_build():
			if is_instance_valid($PathLine):
				$PathLine.position = -position
				$PathLine.points = nav_agent.get_current_navigation_path()
			
			if is_instance_valid($DestinationLine): $DestinationLine.points[1] = next_location - position
		else:
			if is_instance_valid($PathLine): $PathLine.hide()
			if is_instance_valid($DestinationLine): $DestinationLine.hide()
	
	if is_instance_valid(state_handler):
		var rounded_pos = snapped(position, Vector2(VEL_LIMIT, VEL_LIMIT))
		if rounded_pos != old_pos:
			state_machine.set_state(TroopStateMachine.State.WALKING)
		else:
			state_machine.set_state(TroopStateMachine.State.IDLE)
		old_pos = rounded_pos
		
		var troop_state = state_machine.get_state()
		if troop_state == TroopStateMachine.State.IDLE: state_handler._state_idle()
		elif troop_state == TroopStateMachine.State.WALKING: state_handler._state_walking()
		elif troop_state == TroopStateMachine.State.BALLS: state_handler._state_balls()

func _initialize_state_machine():
	state_machine = TroopStateMachine.new().set_state(TroopStateMachine.State.IDLE)

# Function to initialize troop stats
func _initialize_stats():
	stats = TroopStats.new()

func navigate_to(location: Vector2):
	nav_agent.set_target_position(location)
	navigating = true

func _on_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity
	move_and_slide()
	velocity = Vector2.ZERO

func _on_target_reached():
	navigating = false
