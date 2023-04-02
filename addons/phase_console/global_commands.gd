extends Node


func _on_help_command_command_executed(used_alias, arguments):
	var command_list = get_tree().get_nodes_in_group("CommandBuilder")
	
	PhaseConsole.log_output("=== HELP ===")
	
	for command in command_list:
		var alias_builder = ""
		var alias_index = 0
		for alias in command.alias:
			if alias_index == command.alias.size() - 1: alias_builder += alias
			else: alias_builder += alias + "/"
			alias_index += 1
		
		var indexable_arguments = command.arguments.duplicate()
		indexable_arguments.merge({"nullspace": "nullspace"})
		
		var argument_builder = ""
		var arg_index = 0
		for arg in indexable_arguments:
			if arg_index != indexable_arguments.size() - 1:
				argument_builder += "<" + arg + "> "
			arg_index += 1
		
		if indexable_arguments.size() > 1: PhaseConsole.log_output(alias_builder + " | " + argument_builder)
		else: PhaseConsole.log_output(alias_builder)
	
	PhaseConsole.log_output("============")

func _on_clear_command_command_executed(used_alias, arguments):
	PhaseConsole.command_output.text = ""
