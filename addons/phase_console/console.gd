extends CanvasLayer


var console_open = false

var previous_commands = []
var prev_index = 0
var can_change_index = true

var action_list = []
var collected_action_list = []
var input_list = []

@onready var background: Panel = $Background
@onready var command_input: LineEdit = $Background/VSplitContainer/CommandInput
@onready var command_output: RichTextLabel = $Background/VSplitContainer/CommandOutput
@onready var show_timer: Timer = $Background/Timer


func _ready():
	command_input.hide()
	command_output.hide()

func _process(_delta):
	if command_output.text == "":
		command_output.hide()
	
	if console_open:
		command_input.grab_focus()
		command_input.show()
		command_output.show()
	else:
		command_input.hide()
	
	if is_instance_valid(get_viewport().get_camera_2d()):
		background.global_position = -background.get_viewport_transform().origin / background.get_viewport().get_camera_2d().zoom
		background.size = Vector2(DisplayServer.window_get_size())
	else:
		background.global_position = Vector2.ZERO
		background.size = Vector2(DisplayServer.window_get_size())

func _physics_process(_delta):
	get_tree().root.move_child(self, get_tree().root.get_node("/root").get_child_count())
	
	if Input.is_key_pressed(KEY_F11):
		console_open = true
		action_list = InputMap.get_actions()
		
		input_list = []
		collected_action_list = []
		
		for action in action_list:
			if action.findn("ui_") != 0:
				InputMap.action_erase_events(action)
	
	if console_open:
		if Input.is_key_pressed(KEY_ENTER):
			console_open = false
			
			InputMap.load_from_project_settings()
			
			if command_input.text != "": run_command()
	
		if Input.is_key_label_pressed(KEY_DOWN):
			if previous_commands.size() > 0 and can_change_index:
				can_change_index = false
				prev_index += 1
				if prev_index >= previous_commands.size(): prev_index = 0
				command_input.text = previous_commands[prev_index]
		
		if Input.is_key_pressed(KEY_UP):
			if previous_commands.size() > 0 and can_change_index:
				can_change_index = false
				prev_index -= 1
				if prev_index < 0: prev_index = previous_commands.size() - 1
				command_input.text = previous_commands[prev_index]
	
	if not Input.is_key_pressed(KEY_UP) and not Input.is_key_pressed(KEY_DOWN): can_change_index = true

func log_output(message: String):
	command_output.text += "\n" + message
	
	command_output.show()

func run_command():
	var command_builders = get_tree().get_nodes_in_group("CommandBuilder")
	var command_parts = command_input.text.split(".")
	var command_arguments = command_parts.duplicate(); command_arguments.remove_at(0)
	
	if previous_commands.has(command_input.text): previous_commands.erase(command_input.text)
	previous_commands.append(command_input.text)
	prev_index = 0
	
	var raw_input = command_input.text
	command_input.text = ""
	
	var converted_arguments = []
	for arg in command_arguments:
		converted_arguments.append(str_to_var(arg))
	
	var selected_command
	for command_builder in command_builders:
		if command_builder.alias.has(command_parts[0]):
			selected_command = command_builder
			break
	
	if selected_command == null:
		log_output("Invalid command (" + raw_input + ")")
		return
	
	if command_arguments.size() != selected_command.arguments.size():
		log_output("Invalid Argument count (" + str(command_arguments.size()) + " in input, there should be " + str(selected_command.arguments.size()) + " in command")
		return
	
	var argument_index = 0
	for argument in command_arguments:
		var converted_arg = str_to_var(argument)
		var command_arg = selected_command.arguments.values()[argument_index]
		
		if typeof(converted_arg) != typeof(command_arg):
			log_output("Invalid argument type. \"" + str(argument) + "\" is of type \"" + str(typeof(converted_arg)) + "\" but should be \"" + str(typeof(command_arg)) + "\"")
			return
		
		argument_index += 1
	
	selected_command._execute_command(command_parts[0], converted_arguments)
