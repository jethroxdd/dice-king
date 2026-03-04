class_name Player
extends Entity

var energy: int
var max_energy: int
var focus: int
var max_focus: int
var dice: Array[Die] = []
var artifacts: Array = []

func _init():
	super("Player", 100)
	max_energy = 3
	energy = max_energy
	max_focus = 3
	focus = max_focus

func start_round():
	energy = max_energy
	# Щит сбрасывается каждый раунд (можно изменить артефактом)
	shield = 0

func take_damage(source: Entity, damage: int) -> int:
	var had_shield = shield > 0
	var actual_damage = max(0, damage - shield)
	shield = max(0, shield - damage)
	health -= actual_damage
	if had_shield and shield == 0:
		GameManager.artifact_manager.on_player_shield_broken.emit(self, source)
	return actual_damage

func can_roll() -> bool:
	return energy > 0

func roll_die(die_index: int) -> RollResult:
	if not can_roll():
		return RollResult.default()
	if die_index < 0 or die_index >= dice.size():
		return RollResult.default()
	energy -= 1
	return dice[die_index].roll()

func add_die(die: Die):
	dice.append(die)

func get_dice_count() -> int:
	return dice.size()
