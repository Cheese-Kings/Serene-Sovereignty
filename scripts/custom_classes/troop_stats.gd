class_name TroopStats
extends Resource


enum Role {
	Loser,
	Swordsman,
	Archer,
	Farmer,
	Wizard
}


var health := 0
var speed := 0
var role := 0


func set_health(troop_health: int) -> TroopStats:
	health = troop_health
	return self

func set_speed(troop_speed: int) -> TroopStats:
	speed = troop_speed
	return self

func set_role(troop_role: Role) -> TroopStats:
	role = troop_role
	return self
