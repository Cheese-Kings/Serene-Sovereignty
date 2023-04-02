@tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("PhaseConsole", "res://addons/phase_console/console.tscn")
	add_autoload_singleton("GlobalCommands", "res://addons/phase_console/global_commands.tscn")
	
	add_custom_type("CommandBuilder", "Node", preload("res://addons/phase_console/command_builder.gd"), preload("res://addons/phase_console/command_builder.png"),)

func _exit_tree():
	remove_autoload_singleton("PhaseConsole")
	remove_autoload_singleton("GlobalCommands")
	
	remove_custom_type("CommandBuilder")
