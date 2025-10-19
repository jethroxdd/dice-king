# main.gd (пример тестирования)
extends Node

# Создаем экземпляры игрока и врага с начальными параметрами
var player: Player = Player.new()
var enemies: Array[Enemy] = [
	WeakGoblin.new(),
	WeakGoblin.new(),
	WeakGoblin.new()
	]

# Инициализируем менеджер боя между игроком и врагом
var battle: BattleManager = BattleManager.new(player, enemies)

var logs: String = ""  # Переменная для хранения логов боя

func _ready():
	# Создаем игровые кости с разными характеристиками:
	# Атакующая кость (D6) с рунами урона на всех гранях
	var attack_die = Die.new(6, [DamageRune1.new(), DamageRune1.new(), DamageRune1.new(), DamageRune1.new(), DamageRune1.new(), DamageRune1.new()])
	# Защитная кость (D4) с комбинацией пустых рун и рун защиты
	var shield_die = Die.new(4, [ShieldRune1.new(), ShieldRune1.new(), ShieldRune1.new(), ShieldRune1.new()])
	# Яддовитая кость (D4) с комбинацией пустых рун и рун защиты
	var poison_die = Die.new(4, [PoisonRune.new(), PoisonRune.new(), PoisonRune.new(), PoisonRune.new()])
	
	# Добавляем созданные кости в инвентарь игрока
	player.add_die(attack_die)
	player.add_die(shield_die)
	player.add_die(poison_die)
	
	# Создаем UI элементы для управления костями
	create_buttons(len(player.dice))
	create_enemies()
	# Подключаем сигнал кнопки применения хода
	$test_ui/ApplyBtn.pressed.connect(apply)
	
	# Инициализируем начальное состояние интерфейса
	update_stats()
	update_energy()
	update_log("=== НАЧАЛО БОЯ ===")
	next_round()  # Запускаем первый раунд

func _process(_delta):
	var winner = battle.get_winner()
	if not winner == "":
		$WinnerLbl.text = "%s wins" % winner
		$WinnerLbl.visible = true
		$test_ui.visible = false

# Создает кнопки для каждой кости в инвентаре игрока
func create_buttons(button_count: int):
	# Получаем всплывающие подсказки для каждой кости
	var dice_tooltip_text = []
	for i in range(len(player.dice)):
		dice_tooltip_text.append(player.dice[i].tooltip_text)
	
	for i in range(button_count):
		# Создаем экземпляр кнопки из префаба
		var button = preload("res://scenes/test_die_ui.tscn").instantiate()
		button.name = "DieBtn%d" % i
		button.text = "Кость %d" % i
		button.tooltip_text = dice_tooltip_text[i]  # Устанавливаем подсказку
		# Подключаем сигнал нажатия с передачей индекса кости
		button.pressed.connect(die_roll.bind(i))
		$test_ui/HBoxContainer.add_child(button)  # Добавляем в контейнер

func create_enemies():
	var i = 0
	for enemy in enemies:
		var enemy_ui = preload("res://scenes/enemy_ui.tscn").instantiate()
		enemy_ui.enemy = enemy
		if i == 0: enemy_ui.select()
		enemy_ui.selected.connect(select_target_btn.bind(i))
		$test_ui/HBoxContainer2.add_child(enemy_ui)
		i += 1

# Обновляет отображение статистики персонажей
func update_stats():
	var player_str = "Здровье: %d\nЩит: %d\nЭффекты: %s" % [player.health, player.shield, player.get_effects_string()]
	$test_ui/PlayerStats.text = player_str
	for enemy_ui in $test_ui/HBoxContainer2.get_children():
		enemy_ui.update_stats()
		enemy_ui.update_intention()

# Обновляет отображение энергии игрока
func update_energy():
	$test_ui/energy.text = "Энергия %d" % player.energy

# Добавляет новую запись в лог боя
func update_log(new_line: String):
	logs += "\n%s" % new_line
	$test_ui/log.text = logs

# Добавление записи примененных эффектво в лог боя
func update_log_effect(sorce: Entity, applyed_effects: Dictionary):
	for effect_type in applyed_effects:
		var effect_value = applyed_effects[effect_type]
		match effect_type:
			"poison":
				update_log("%s получил %d урона ядом" % [sorce.name, effect_value])

# Обрабатывает бросок конкретной кости игроком
func die_roll(i: int):
	# Просим BattleManager обработать бросок
	var result = battle.process_player_roll(i)
	if not result.is_empty():
		# Логируем результат броска
		update_log("Кость %d: Руна %s Значение: %d" % [i + 1, result["rune"].name, result["face"]])
		update_log("Эффект: %s" % result["rune"].get_log(result["face"]))
	# Обновляем показатели после броска
	update_stats()
	update_energy()

func select_target_btn(idx):
	battle.set_target(idx)

# Обрабатывает завершение хода игрока
func apply():
	var applyed_effects: Dictionary = {}
	# Активация эфффектов игрока
	applyed_effects = player.apply_effects()
	update_log_effect(player, applyed_effects)

	# Враг выполняет свой ход
	battle.process_enemy_turn()
	for enemy in enemies:
		update_log("Враг: %s" % enemy.intention.log_text)

	# Активация эфффектов противника
	for enemy in enemies:
		applyed_effects = enemy.apply_effects()
		update_log_effect(enemy, applyed_effects)
	
	# Переходим к следующему раунду
	next_round()

# Начинает новый раунд боя
func next_round():
	battle.start_round()
	update_log("=== РАУНД %d ===" % battle.current_round)
	# Обновляем все элементы интерфейса
	update_energy()
	update_stats()
