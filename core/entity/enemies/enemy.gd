class_name Enemy
extends Entity

var move_count: int = 0

var intention: Intention = Intention.new("none", 0, "none", "none")

func _init(enemy_name: String, initial_health: int):
	super(enemy_name, initial_health)

func intenton_AI() -> Intention:
	return Intention.default()

func make_move():
	if health <= 0:
		intention =  Intention.new("died", 0, "Повержен", "")
	else:
		intention = intenton_AI()
	
func start_round():
	# Щит сбрасывается каждый раунд (можно изменить артефактом)
	move_count += 1
	shield = 0
