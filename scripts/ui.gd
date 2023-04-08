extends Control


func _process(_delta):
	$"%GoldDisplay".text = str(GameStats.gold)
	$"%DayCounter".text = "Day " + str(GameStats.current_day)
	
	$"%FarmLevel".text = str(GameStats.farm_level)
	$"%FarmUpgradeCost".text = str(GameStats.farm_upgrade_cost)
	
	
	$"%LoserBuyButton".purchase_price = GameStats.current_loser_cost
	$"%LoserPrice".text = str(GameStats.current_loser_cost)
	
	$"%SwordsmanBuyButton".purchase_price = GameStats.current_swordsman_cost
	$"%SwordsmanPrice".text = str(GameStats.current_swordsman_cost)
	
	$"%ArcherBuyButton".purchase_price = GameStats.current_archer_cost
	$"%ArcherPrice".text = str(GameStats.current_archer_cost)
	
	$"%FarmerBuyButton".purchase_price = GameStats.current_farmer_cost
	$"%FarmerPrice".text = str(GameStats.current_farmer_cost)
	
	$"%WizardBuyButton".purchase_price = GameStats.current_wizard_cost
	$"%WizardPrice".text = str(GameStats.current_wizard_cost)
	
	$"%ShieldmanBuyButton".purchase_price = GameStats.current_shieldman_cost
	$"%ShieldmanPrice".text = str(GameStats.current_shieldman_cost)

func _on_settings_pressed():
	SaveSystem.save_game()

func _on_upgrade_farm_pressed():
	if GameStats.gold >= GameStats.farm_upgrade_cost:
		GameStats.farm_level += 1
		GameStats.gold -= GameStats.farm_upgrade_cost
		GameStats.farm_upgrade_cost *= 1.5

func _on_farm_house_button_pressed():
	GameStats.gold += GameStats.farm_level
