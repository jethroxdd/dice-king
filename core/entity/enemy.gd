class_name Enemy
extends Entity

var attack_damage: int
var ai_type: String = "basic" # basic, aggressive, defensive, etc.
var intention: Dictionary

func _init(initial_health: int, damage: int):
	super(initial_health)
	attack_damage = damage

func make_move() -> Dictionary:
	# Простой AI - просто атакует
	var attack1 = {
		"type": "damage", 
		"value": attack_damage,
		"description": "Атакует на %d урона" % attack_damage
	}
	var attack2 = {
		"type": "damage", 
		"value": (attack_damage*2),
		"description": "Атакует на %d урона" % (attack_damage*2)
	}
	var deffense1 = {
		"type": "shield", 
		"value": 10,
		"description": "Защищается"
	}
	return [attack1, attack2, deffense1][randi() % 3]
	
func start_round():
	# Щит сбрасывается каждый раунд (можно изменить артефактом)
	shield = 0
