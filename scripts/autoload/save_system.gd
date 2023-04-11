extends Node


func save_game():
	var player_troops = get_tree().get_nodes_in_group("Troop")
	var troop_container = get_tree().get_first_node_in_group("TroopContainer")
	var current_time = TimeCycle.current_time
	var current_day = GameStats.current_day
	var gold_amount = GameStats.gold
	var farm_level = GameStats.farm_level
	var enemies_killed = GameStats.enemies_killed
	
	var save_folder = DirAccess.make_dir_absolute("user://save_data")
	
	for troop in troop_container.get_children():
		troop.set_owner(troop_container)
	
	var packed_container = PackedScene.new()
	packed_container.pack(troop_container)
	ResourceSaver.save(packed_container, "user://save_data/troops.tscn")
	
	var data_file = FileAccess.open("user://save_data/stats.data", FileAccess.WRITE)
	data_file.store_line(str(gold_amount))
	data_file.store_line(str(current_day))
	data_file.store_line(str(current_time))
	data_file.store_line(str(farm_level))
	data_file.store_line(str(enemies_killed))
	data_file.flush()
	
	var save_indicator = get_tree().get_first_node_in_group("SaveIndicator")
	if save_indicator != null:
		save_indicator.get_node("AnimationPlayer").stop()
		save_indicator.get_node("AnimationPlayer").play("Saved")

func save_settings():
	var settings_file = FileAccess.open("user://settings.data", FileAccess.WRITE)
	settings_file.store_line(str(SettingValues.sfx_volume))
	settings_file.store_line(str(SettingValues.music_volume))
	settings_file.store_line(str(float(SettingValues.enable_clouds)))
	settings_file.flush()

func load_game():
	if FileAccess.file_exists("user://save_data/troops.tscn"):
		var saved_container = load("user://save_data/troops.tscn")
		
		get_tree().get_first_node_in_group("TroopContainer").queue_free()
		
		var instanced_container = saved_container.instantiate()
		
		get_tree().get_first_node_in_group("ProjectileContainer").add_sibling(instanced_container)
	
	if FileAccess.file_exists("user://save_data/stats.data"):
		var stat_file = FileAccess.open("user://save_data/stats.data", FileAccess.READ)
		var split_lines = stat_file.get_as_text().split("\n")
		
		GameStats.gold = split_lines[0].to_int()
		GameStats.current_day = split_lines[1].to_int()
		TimeCycle.current_time = split_lines[2].to_int()
		GameStats.farm_level = split_lines[3].to_int()
		GameStats.enemies_killed = split_lines[4].to_int()
		
		for num in range(GameStats.farm_level):
			GameStats.farm_upgrade_cost *= 1.5
	
	if FileAccess.file_exists("user://settings.data"):
		var settings_file = FileAccess.open("user://settings.data", FileAccess.READ)
		var split_lines = settings_file.get_as_text().split("\n")
		
		SettingValues.sfx_volume = split_lines[0].to_int()
		SettingValues.music_volume = split_lines[1].to_int()
		SettingValues.enable_clouds = bool(float(split_lines[2]))
		
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), split_lines[0].to_int())
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), split_lines[1].to_int())
		
		get_tree().get_first_node_in_group("SettingsMenu").update_settings()
	
	get_tree().get_first_node_in_group("Game").enable_losing = true

func delete_save_data():
	var save_files = DirAccess.get_files_at("user://save_data")
	for file in save_files:
		DirAccess.remove_absolute("user://save_data/" + file)
	DirAccess.remove_absolute("user://save_data")
