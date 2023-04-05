extends TextureButton


@export var troop_container: Node2D
@export var troop_to_purchase: PackedScene
@export var replace_loser := true

var purchase_price: int = 1


func _on_pressed():
	if GameStats.gold >= purchase_price:
		if replace_loser: if get_tree().get_nodes_in_group("Loser").size() <= 0: return
		
		GameStats.gold -= purchase_price
		
		if replace_loser:
			var troop_instance = troop_to_purchase.instantiate()
			var losers = get_tree().get_nodes_in_group("Loser")
			
			randomize()
			var selected_loser = randi_range(0, losers.size() - 1)
			
			troop_instance.position = losers[selected_loser].position
			
			losers[selected_loser].queue_free()
			troop_container.add_child(troop_instance)
		else:
			var troop_instance = troop_to_purchase.instantiate()
			troop_instance.position.y = 56
			troop_container.add_child(troop_instance)
