class_name Enemy
extends Entity

var attack_damage: int
var ai_type: String = "basic" # basic, aggressive, defensive, etc.
var intention: Dictionary

func _init(enemy_name: String, initial_health: int, damage: int):
	super(enemy_name, initial_health)
	attack_damage = damage

func make_move() -> Dictionary:
	# Простой AI
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
	var deffense2 = {
		"type": "shield", 
		"value": 15,
		"description": "Защищается"
	}
	return [attack1, attack2, deffense1, deffense2][randi() % 4]
	
func start_round():
	# Щит сбрасывается каждый раунд (можно изменить артефактом)
	shield = 0
