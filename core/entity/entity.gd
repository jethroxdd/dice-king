class_name Entity
extends RefCounted

var max_health: int
var health: int
var shield: int = 0

func _init(initial_health: int):
	max_health = initial_health
	health = initial_health

func take_damage(damage: int) -> int:
	var actual_damage = max(0, damage - shield)
	shield = max(0, shield - damage)
	health -= actual_damage
	return actual_damage

func heal(amount: int):
	health = min(health + amount, max_health)

func has_shield() -> bool:
	return shield > 0
