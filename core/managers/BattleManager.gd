# Класс для управления логикой боя между игроком и противником
class_name BattleManager
extends RefCounted

# Ссылки на участников боя
var player: Player
var enemies: Array[Enemy]
var target: Enemy
# Текущий номер раунда (начинается с 0)
var current_round: int = 0

# Конструктор, принимает ссылки на игрока и противника
func _init(player_ref: Player, enemies_ref: Array[Enemy]):
	player = player_ref
	enemies = enemies_ref
	set_target(0)

func set_target(new_target_idx: int):
	target = enemies[new_target_idx]

# Начало нового раунда боя
func start_round():
	current_round += 1
	# Обновляем состояние игрока
	player.start_round()
	# Противник выбирает действие для этого раунда
	for enemy in enemies:
		enemy.make_move()

# Обработка броска игрока
func process_player_roll(die_index: int) -> Dictionary:
	# Получаем результат броска кубика
	var result = player.roll_die(die_index)

	# Проверяем валидность результата
	if result.is_empty():
		return {}

	# Применяем эффект руны с полученным значением
	result["rune"].apply(player, target, result["face"])
	return result

# Обработка хода противника
func process_enemy_turn():
	for enemy in enemies:
		if enemy.health <= 0:
			continue
		enemy.start_round()
		var result: Intention = enemy.intention
	
		# Проверяем наличие запланированного действия
		if result.type == "none":
			return
	
	# Выполняем действие в зависимости от типа
		match result.type:
			"damage":
				player.take_damage(result["value"])
			"shield":
				enemy.take_shield(result["value"])
			"heal":
				enemy.heal(result["value"])

# Проверка окончания боя
func is_battle_over() -> bool:
	var is_any_enemy_alive = false
	for enemy in enemies:
		if enemy.health > 0:
			is_any_enemy_alive = true
	return player.health <= 0 or not is_any_enemy_alive

# Определение победителя
func get_winner() -> String:
	if not is_battle_over():
		return ""
	if player.health <= 0:
		return "enemy"
	else:
		return "player"
