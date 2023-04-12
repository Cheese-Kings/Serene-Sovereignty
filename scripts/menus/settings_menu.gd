extends Control


@export var hide_pause_background = true

@onready var button_click = $ButtonClick
@onready var sfx_volume_slider = $Settings/SfxVolume/SfxVolumeSlider
@onready var music_volume_slider = $Settings/MusicVolume/MusicVolumeSlider
@onready var cloud_enable_box = $Settings/Clouds/CloudEnableBox
@onready var fullscreen_enable_box = $Settings/FullScreen/FullscreenEnableBox


func update_settings():
	sfx_volume_slider.value = SettingValues.sfx_volume
	music_volume_slider.value = SettingValues.music_volume
	cloud_enable_box.button_pressed = SettingValues.enable_clouds
	fullscreen_enable_box.button_pressed = SettingValues.fullscreen

func _on_apply_settings_pressed():
	button_click.play()
	if hide_pause_background: get_parent().get_node("Background").show()
	hide()
	SettingValues.sfx_volume = sfx_volume_slider.value
	SettingValues.music_volume = music_volume_slider.value
	SettingValues.enable_clouds = cloud_enable_box.button_pressed
	SettingValues.fullscreen = fullscreen_enable_box.button_pressed
	SaveSystem.save_settings()
	SaveSystem.load_settings()

func _on_cloud_enable_box_pressed():
	button_click.play()

func _on_fullscreen_enable_box_pressed():
	button_click.play()

func _on_sfx_volume_slider_drag_ended(_value_changed):
	button_click.play()

func _on_music_volume_slider_drag_ended(_value_changed):
	button_click.play()
