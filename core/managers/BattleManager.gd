# Класс для управления логикой боя между игроком и противником
class_name BattleManager
extends RefCounted

# Ссылки на участников боя
var player: Player
var enemy: Enemy
# Текущий номер раунда (начинается с 0)
var current_round: int = 0

# Конструктор, принимает ссылки на игрока и противника
func _init(player_ref: Player, enemy_ref: Enemy):
	player = player_ref
	enemy = enemy_ref

# Начало нового раунда боя
func start_round():
	current_round += 1
	# Обновляем состояние игрока
	player.start_round()
	# Противник выбирает действие для этого раунда
	enemy.intention = enemy.make_move()

# Обработка броска игрока
func process_player_roll(die_index: int) -> Dictionary:
	# Получаем результат броска кубика
	var result = player.roll_die(die_index)

	# Проверяем валидность результата
	if result.is_empty():
		return {}

	# Применяем эффект руны с полученным значением
	result["rune"].apply(player, enemy, result["face"])
	return result

# Обработка хода противника
func process_enemy_turn() -> Dictionary:
	var result = enemy.intention
	
	# Проверяем наличие запланированного действия
	if result.is_empty():
		return {}
	
	# Выполняем действие в зависимости от типа
	match result["type"]:
		"damage":
			player.take_damage(result["value"])
		"shield":
			enemy.shield += result["value"]
		"heal":
			enemy.heal(result["value"])
	return result

# Проверка окончания боя
func is_battle_over() -> bool:
	return player.health <= 0 or enemy.health <= 0

# Определение победителя
func get_winner() -> String:
	if player.health <= 0:
		return "enemy"
	elif enemy.health <= 0:
		return "player"
	return ""  # Пустая строка если бой продолжается
