class_name BattleUI
extends Control

var player: Player = GameManager.player

var dice_nodes: Array:
	get:
		return $DiceContainer.get_children()

var enemies_nodes: Array:
	get:
		return $EnemiesContainer.get_children()

var log_label: RichTextLabel
var log_text: String = ""
var energy_label: Label
var player_stats_label: Label
var apply_button: Button

func _ready() -> void:
	log_label = $Log
	energy_label = $Energy
	player_stats_label = $PlayerStats
	apply_button = $ApplyButton
	# Подключение сигнала для обновления логов
	EventBus.update_log.connect(update_log)
	EventBus.update_battle_ui.connect(update_energy)
	EventBus.update_battle_ui.connect(update_stats)
	EventBus.update_battle_ui.connect(update_dice_tooltip)

## Добавляет новую запись в лог боя
func update_log(new_line: String):
	log_text += "\n%s" % new_line
	log_label.text = log_text

## Обновляет отображение энергии игрока
func update_energy():
	energy_label.text = "Энергия %d" % player.energy

## Обновляет отображение статистики персонажей
func update_stats():
	var player_str = "Здровье: %d\nЩит: %d\nЭффекты: %s" % [player.health, player.shield, player.get_effects_string()]
	player_stats_label.text = player_str
	for enemy_ui in enemies_nodes:
		enemy_ui.update_stats()
		enemy_ui.update_intention()

## Создает элементы врагов в UI
func create_enemies(enemies: Array[Enemy], select_target_btn: Callable):
	var i = 0
	for enemy in enemies:
		var enemy_ui = preload("res://scenes/battle/enemy_ui.tscn").instantiate()
		enemy_ui.enemy = enemy
		if i == 0: enemy_ui.select()
		enemy_ui.selected.connect(select_target_btn.bind(i))
		$EnemiesContainer.add_child(enemy_ui)
		i += 1

## Создает кнопки для каждой кости в инвентаре игрока
func create_buttons(die_roll: Callable):
	# Получаем всплывающие подсказки для каждой кости
	var button_count = len(player.dice)
	
	for i in range(button_count):
		# Создаем экземпляр кнопки из префаба
		var button = preload("res://scenes/battle/die_ui.tscn").instantiate()
		button.name = "DieBtn%d" % i
		button.text = "Кость %d" % i
		# Подключаем сигнал нажатия с передачей индекса кости
		button.pressed.connect(die_roll.bind(i))
		$DiceContainer.add_child(button)  # Добавляем в контейнер
	update_dice_tooltip()

func connect_apply_button(callback: Callable):
	$ApplyButton.pressed.connect(callback)

## Обновляет описание кубиков
func update_dice_tooltip():
	var i = 0
	for die in player.dice:
		dice_nodes[i].tooltip_text = die.tooltip_text
		i += 1
