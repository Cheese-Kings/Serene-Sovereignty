extends Control


@onready var camera = $Camera
@onready var continue_button = $ContinueButton
@onready var settings_menu = $SettingsMenu
@onready var menu_music = $MenuMusic
@onready var button_click = $ButtonClick


func _ready():
	if not DirAccess.dir_exists_absolute("user://save_data"):
		continue_button.hide()
	
	SaveSystem.load_settings()

func _on_continue_button_pressed():
	button_click.play()
	ArcLoader.change_scene("res://scenes/game.tscn")

func _on_new_game_button_pressed():
	button_click.play()
	SaveSystem.delete_save_data()
	ArcLoader.change_scene("res://scenes/game.tscn")

func _on_settings_button_pressed():
	button_click.play()
	settings_menu.show()

func _on_quit_button_pressed():
	button_click.play()
	get_tree().quit()

func _on_menu_music_finished():
	menu_music.play()
