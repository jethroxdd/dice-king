class_name Player
extends Entity

var energy: int
var max_energy: int
var dice: Array[Die] = []
var artifacts: Array = []

func _init():
	super(100)
	energy = 3
	max_energy = 3

func start_round():
	energy = max_energy
	# Щит сбрасывается каждый раунд (можно изменить артефактом)
	shield = 0

func can_roll() -> bool:
	return energy > 0

func roll_die(die_index: int) -> Dictionary:
	if not can_roll():
		return {}
	if die_index < 0 or die_index >= dice.size():
		return {}
	
	energy -= 1
	return dice[die_index].roll()

func add_die(die: Die):
	dice.append(die)

func get_dice_count() -> int:
	return dice.size()
