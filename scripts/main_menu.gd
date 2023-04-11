extends Control


@onready var camera = $Camera
@onready var continue_button = $ContinueButton
@onready var settings_menu = $SettingsMenu


func _ready():
	if not DirAccess.dir_exists_absolute("user://save_data"):
		continue_button.hide()

func _on_continue_button_pressed():
	ArcLoader.change_scene("res://scenes/game.tscn")

func _on_new_game_button_pressed():
	SaveSystem.delete_save_data()
	ArcLoader.change_scene("res://scenes/game.tscn")

func _on_settings_button_pressed():
	settings_menu.show()

func _on_quit_button_pressed():
	get_tree().quit()
