# Этот код надо полность рефакторить
# Главная функция этого файла - главный менеджер боя
# Он должен управлять UI и циклом боя через BattleManager
# Нужно понемногу делегировать задачи в соответствующие классы
class_name BattleEncounter
extends Node

# Создаем экземпляры игрока и врага
var player: Player = GameManager.player
var enemies: Array[Enemy] = [
	WeakGoblin.new(),
	WeakGoblin.new(),
	WeakGoblin.new()
	]

# Инициализируем менеджер боя между игроком и врагом
var battle: BattleManager = BattleManager.new(enemies)

# Объект для работы с интерфейсом
@onready
var UI: BattleUI = $BattleUI

func _ready():
	# Создаем UI элементы для управления костями
	UI.create_buttons(die_roll)
	UI.create_enemies(enemies, select_target_btn)
	# Подключаем сигнал кнопки применения хода
	UI.connect_apply_button(apply)
	
	# Инициализируем начальное состояние интерфейса
	EventBus.update_battle_ui.emit()
	EventBus.update_log.emit("=== НАЧАЛО БОЯ ===")
	next_round()  # Запускаем первый раунд

func _process(_delta):
	var winner = battle.get_winner()
	if not winner == "":
		$WinnerLabel.text = "%s wins" % winner
		$WinnerLabel.visible = true
		UI.visible = false

# Обрабатывает бросок конкретной кости игроком
func die_roll(i: int):
	# Просим BattleManager обработать бросок
	battle.process_player_roll(i)
	# Обновляем показатели после броска
	EventBus.update_battle_ui.emit()

# Установка текущей цели игрока
# Устанавливается по сигналу кнопки
func select_target_btn(idx):
	battle.set_target(idx)

# Обрабатывает завершение хода игрока
# Обрабатывается по сигналу кнопки
func apply():
	# Игрок заканчивает ход
	EventBus.round_end.emit()
	battle.end_player_round()
	
	# Враги выполняют свой ход
	battle.start_enemies_round()
	battle.end_enemies_round()
	# Переходим к следующему раунду
	next_round()

# Начинает новый раунд боя
func next_round():
	EventBus.round_start.emit()
	# Обновление игры
	battle.start_round()
	# Начало хода игрока
	battle.start_player_round()
	
	EventBus.update_log.emit("=== РАУНД %d ===" % battle.current_round)
	# Обновляем все элементы интерфейса
	EventBus.update_battle_ui.emit()
