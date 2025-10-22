class_name Enemy
extends Entity

var move_count: int = 0

var intention: Intention = Intention.get_default()

func _init(enemy_name: String, initial_health: int):
	super(enemy_name, initial_health)

func take_damage(source: Entity, damage: int) -> int:
	super.take_damage(source, damage)
	if not is_alive:
		intention =  Intention.get_died()
	return damage

func take_true_damage(damage: int) -> int:
	super.take_true_damage(damage)
	if not is_alive:
		intention =  Intention.get_died()
	return damage

func intenton_AI() -> Intention:
	return Intention.get_default()

func update_intention():
	if not is_alive:
		intention =  Intention.get_died()
	else:
		intention = intenton_AI()
	
func start_round():
	# Щит сбрасывается каждый раунд (можно изменить артефактом)
	move_count += 1
	shield = 0
