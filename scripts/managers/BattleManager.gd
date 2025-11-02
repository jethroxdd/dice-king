## Класс для управления логикой боя между игроком и противником[br]
## Обрабатывает очередность ходов, применение способностей и определение победителя
class_name BattleManager
extends RefCounted

# Ссылки на участников боя
## Ссылка на игрока
var player: Player = GameManager.player
## Массив врагов
var enemies: Array[Enemy]
## Текуйщий выбранны враг[br]
## По умолчанию первый
var target: Enemy
## Текущий номер раунда (начинается с 0)[br]
## Инкрементируется каждый раз при вызове [method start_round]
var current_round: int = 0

## Конструктор, принимает ссылки на игрока и противника[br]
## [br]
## [b]Параметры:[/b][br]
## [param player_ref] - Ссылка на объект [Player][br]
## [param enemies_ref] - Массив объектов [Enemy]
func _init( enemies_ref: Array[Enemy]):
	enemies = enemies_ref
	player.focus = player.max_focus
	set_target(0)

## Установка текущей цели для атак игрока[br]
## [br]
## [b]Параметры:[/b][br]
## [param new_target_idx] - Индекс цели в массиве [member enemies]
func set_target(new_target_idx: int):
	target = enemies[new_target_idx]

## Начало нового раунда боя[br]
## [br]
## [b]Что делает:[/b][br]
## Увеличивает [member current_round] на 1[br]
## Обновляет намерения всех противников через [method Enemy.update_intention]
func start_round():
	current_round += 1
	for enemy in enemies:
		enemy.update_intention()

## Обработка начала раунда игрока[br]
## [br]
## [b]Что делает:[/b][br]
## Вызывает [method Player.start_round][br]
## Применяет эффекты фазы 0 через [method Player.apply_effects]
func start_player_round():
	player.start_round()
	player.apply_effects(0)

## Обработка завершения раунда игрока[br]
## [br]
## [b]Что делает:[/b][br]
## Применяет эффекты фазы 1 через [method Player.apply_effects]
func end_player_round():
	player.apply_effects(1)
	
## Обработка начала раунда противников[br]
## [br]
## [b]Что делает:[/b][br]
## Обрабатывает ходы противников через [method process_enemy_turn][br]
## Выводит в лог намерения всех противников[br]
## Применяет эффекты фазы 0 через [method Enemy.apply_effects]
func start_enemies_round():
	process_enemy_turn()
	for enemy in enemies:
		EventBus.update_log.emit("%s: %s" % [enemy.name, enemy.intention.log_text])
	for enemy in enemies:
		enemy.apply_effects(0)

## Обработка завершения раунда противников[br]
## [br]
## [b]Что делает:[/b][br]
## Применяет эффекты фазы 1 через [method Enemy.apply_effects]
func end_enemies_round():
	for enemy in enemies:
		enemy.apply_effects(1)

func reset_die(die_inedx: int):
	if player.focus > 0:
		player.dice[die_inedx].reset_remaining_faces()
		player.focus -= 1
		EventBus.update_log.emit("Использован фокус")
		EventBus.update_battle_ui.emit()
	else:
		EventBus.update_log.emit("Фокусы кончились")

## Обработка броска игрока[br]
## [br]
## [b]Параметры:[/b][br]
## [param die_index] - Индекс кубика в коллекции игрока[br]
## [br]
## [b]Что делает:[/b][br]
## Получает результат броска через [method Player.roll_die][br]
## Проверяет валидность результата[br]
## Применяет эффект руны через [method Rune.apply]
func process_player_roll(die_index: int):
	var roll_result: RollResult = player.roll_die(die_index)

	if roll_result.is_default():
		return
		
	roll_result.rune.apply(player, target, roll_result.face)

## Обработка хода противника[br]
## [br]
## [b]Что делает:[/b][br]
## Для каждого живого противника:[br]
## Определяет тип намерения через [member Intention.type][br]
## Выполняет соответствующее действие:[br]
## [code]"damage"[/code]: наносит урон игроку через [method Player.take_damage][br]
## [code]"shield"[/code]: добавляет защиту через [method Enemy.take_shield][br]
## [code]"heal"[/code]: восстанавливает здоровье через [method Enemy.heal]
func process_enemy_turn():
	for enemy in enemies:
		if not enemy.is_alive:
			continue
		enemy.start_round()
		var intention: Intention = enemy.intention
	
		match intention.type:
			"damage":
				player.take_damage(enemy, intention.value)
			"shield":
				enemy.take_shield(intention.value)
			"heal":
				enemy.heal(intention.value)

## Проверка окончания боя[br]
## [br]
## [b]Возвращает:[/b] [code]bool[/code] - [code]true[/code] если бой завершен, иначе [code]false[/code][br]
## [br]
## [b]Условия завершения:[/b][br]
## Здоровье игрока [code]<= 0[/code] ИЛИ[br]
## Все противники мертвы
func is_battle_over() -> bool:
	var is_any_enemy_alive = false
	for enemy in enemies:
		if enemy.is_alive:
			is_any_enemy_alive = true
	return player.health <= 0 or not is_any_enemy_alive

## Определение победителя[br]
## [br]
## [b]Возвращает:[/b] [code]String[/code] - Строка с идентификатором победителя:[br]
## [code]"player"[/code] - если победил игрок[br]
## [code]"enemy"[/code] - если победили противники[br]
## [code]""[/code] - если бой еще не окончен
func check_battle_end():
	if not is_battle_over():
		return 
	var winner = "player" if player.is_alive else "enemy"
	EventBus.battle_room_over.emit(winner)
