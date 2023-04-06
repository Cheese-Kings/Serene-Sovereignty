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
var attack_range := 0
var attack_power := 0
var attack_cooldown := 0
var role := 0


func set_health(troop_health: int) -> TroopStats:
	health = troop_health
	return self

func set_speed(troop_speed: int) -> TroopStats:
	speed = troop_speed
	return self

func set_attack_range(troop_attack_range: int) -> TroopStats:
	attack_range = troop_attack_range
	return self

func set_attack_power(troop_attack_power: int) -> TroopStats:
	attack_power = troop_attack_power
	return self

func set_attack_cooldown(troop_attack_cooldown: int) -> TroopStats:
	attack_cooldown = troop_attack_cooldown
	return self

func set_role(troop_role: Role) -> TroopStats:
	role = troop_role
	return self
