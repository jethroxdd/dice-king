class_name WeakGoblin
extends Enemy

func _init():
	super("Слабый гоблин", 10)

func intenton_AI() -> Intention:
	match move_count % 3:
		0:
			var moves = [
				Intention.new("damage", 3, "3 урона", "Наносит 3 урона"),
				Intention.new("damage", 5, "5 урона", "Наносит 5 урона")
				]
			return _get_random_item(moves)
		1:
			var moves = [
				Intention.new("shield", 5, "Защищается", "Получает 5 щита"),
				Intention.new("shield", 7, "Защищается", "Получает 7 щита")
				]
			return _get_random_item(moves)
		2:
			var moves = [
				Intention.new("damage", 3, "3 урона", "Наносит 3 урона"),
				Intention.new("shield", 5, "Защищается", "Получает 5 щита")
				]
			return _get_random_item(moves)
	return Intention.default()
