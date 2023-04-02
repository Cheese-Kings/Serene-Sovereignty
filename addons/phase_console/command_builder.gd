@tool
extends Node


signal command_executed(used_alias: String, arguments: Array)

@export var alias: Array[String] = []
@export var arguments: Dictionary = {}


func _ready():
	add_to_group("CommandBuilder")

func _execute_command(used_alias: String, arguments: Array):
	emit_signal("command_executed", used_alias, arguments)
