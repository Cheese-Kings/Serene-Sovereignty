extends Control


@export var hide_pause_background = true

@onready var sfx_volume_slider = $Settings/SfxVolume/SfxVolumeSlider
@onready var music_volume_slider = $Settings/MusicVolume/MusicVolumeSlider
@onready var cloud_enable_box = $Settings/Clouds/CloudEnableBox


func update_settings():
	sfx_volume_slider.value = SettingValues.sfx_volume
	music_volume_slider.value = SettingValues.music_volume
	cloud_enable_box.button_pressed = SettingValues.enable_clouds

func _on_apply_settings_pressed():
	if hide_pause_background: get_parent().get_node("Background").show()
	hide()
	SettingValues.sfx_volume = sfx_volume_slider.value
	SettingValues.music_volume = music_volume_slider.value
	SettingValues.enable_clouds = cloud_enable_box.button_pressed
	SaveSystem.save_settings()
