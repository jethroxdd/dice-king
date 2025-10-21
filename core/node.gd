# main.gd (пример тестирования)
# Этот код надо полность рефакторить
# Главная функция этого файла - главный менеджер боя
# Он должен управлять UI и циклом боя через BattleManager
# Нужно понемногу делегировать задачи в соответствующие классы
class_name BattleEncounter
extends Node

# Создаем экземпляры игрока и врага
var player: Player = Player.new()
var enemies: Array[Enemy] = [
	WeakGoblin.new(),
	WeakGoblin.new(),
	WeakGoblin.new()
	]

# Инициализируем менеджер боя между игроком и врагом
var battle: BattleManager = BattleManager.new(player, enemies)

# Объект для работы с интерфейсом
@onready
var UI: BattleUI = $test_ui

func _ready():
	# Создаем игровые кости с разными характеристиками:
	var attack_die = Die.new(6, [DamageRune1.new(), DamageRune1.new(), DamageRune1.new(), DamageRune1.new(), DamageRune1.new(), DamageRune1.new()])
	var shield_die = Die.new(4, [ShieldRune1.new(), ShieldRune1.new(), ShieldRune1.new(), ShieldRune1.new()])
	var poison_die = Die.new(4, [PoisonRune.new(), PoisonRune.new(), PoisonRune.new(), PoisonRune.new()])
	
	# Добавляем созданные кости в инвентарь игрока
	player.add_die(attack_die)
	player.add_die(shield_die)
	player.add_die(poison_die)
	
	# Создаем UI элементы для управления костями
	UI.create_buttons(player, die_roll)
	UI.create_enemies(enemies, select_target_btn)
	# Подключаем сигнал кнопки применения хода
	$test_ui/ApplyBtn.pressed.connect(apply)
	
	# Инициализируем начальное состояние интерфейса
	UI.update_stats(player)
	UI.update_energy(player)
	Global.update_log.emit("=== НАЧАЛО БОЯ ===")
	next_round()  # Запускаем первый раунд

func _process(_delta):
	var winner = battle.get_winner()
	if not winner == "":
		$WinnerLbl.text = "%s wins" % winner
		$WinnerLbl.visible = true
		$test_ui.visible = false

# Обрабатывает бросок конкретной кости игроком
func die_roll(i: int):
	# Просим BattleManager обработать бросок
	battle.process_player_roll(i)
	# Обновляем показатели после броска
	UI.update_stats(player)
	UI.update_energy(player)
	UI.update_dice_tooltip(player)

# Установка текущей цели игрока
# Устанавливается по сигналу кнопки
func select_target_btn(idx):
	battle.set_target(idx)

# Обрабатывает завершение хода игрока
# Обрабатывается по сигналу кнопки
func apply():
	# Игрок заканчивает ход
	battle.end_player_round()
	
	# Враги выполняют свой ход
	battle.start_enemies_round()
	battle.end_enemies_round()
	# Переходим к следующему раунду
	next_round()

# Начинает новый раунд боя
func next_round():
	# Обновление игры
	battle.start_round()
	# Начало хода игрока
	battle.start_player_round()
	
	Global.update_log.emit("=== РАУНД %d ===" % battle.current_round)
	# Обновляем все элементы интерфейса
	UI.update_energy(player)
	UI.update_stats(player)
