extends Control

@onready var background = $Background
@onready var settings_menu = $SettingsMenu


func pause():
	show()
	get_tree().paused = true

func unpause():
	if not settings_menu.visible:
		hide()
		get_tree().paused = false

func _on_resume_button_pressed():
	unpause()

func _on_save_button_pressed():
	SaveSystem.save_game()
	unpause()

func _on_settings_button_pressed():
	background.hide()
	settings_menu.show()

func _on_exit_to_menu_button_pressed():
	get_tree().paused = false
	SaveSystem.save_game()
	ArcLoader.change_scene("res://scenes/main_menu.tscn")