# main.gd
extends Node

# Создаем игрока
var player = Player.new()
# Создаем врага
var enemy = Enemy.new(50, 5)

# Создаем менеджер боя
var battle = BattleManager.new(player, enemy)

var logs = ""

func _ready():
	
	# Создаем кубики
	var attack_die = Die.new(6)
	var shield_die = Die.new(4)
	
	# Настраиваем грани кубиков
	for i in range(6):
		attack_die.set_face(i, {
			"type": "damage",
			"value": 2 * (i + 1),
			"description": "Наносит %d урона" % (2 * (i + 1))
		})
	
	for i in range(4):
		shield_die.set_face(i, {
			"type": "shield", 
			"value": 3 + (i + 1),
			"description": "Даёт %d щита" % (3 + (i + 1))
		})
	
	player.add_die(attack_die)
	player.add_die(shield_die)
	
	create_buttons(len(player.dice))
	$test_ui/ApplyBtn.pressed.connect(apply)
	update_stats()
	update_energy()
	update_log("=== НАЧАЛО БОЯ ===")
	next_round()

func create_buttons(button_count: int):
	var dice_tooltip_text = [
		"2 атака\n4 атака\n6 атака\n8 атака\n10 атака\n12 атака",
		"4 щит\n5 щит\n6 щит\n7 щит"]
	for i in range(button_count):
		var button = preload("res://scenes/test_die_ui.tscn").instantiate()  # Создаем новую кнопку
		button.name = "DieBtn%d" % i
		button.text = "Кость %d" % i  # Устанавливаем текст
		button.tooltip_text = dice_tooltip_text[i]
		button.pressed.connect(die_roll.bind(i))  # Связываем сигнал с параметром
		$test_ui/HBoxContainer.add_child(button)  # Добавляем в контейнер

func update_stats():
	var player_str = "Здровье: %d\nЩит: %d" % [player.health, player.shield]
	var enemy_str = "Здровье: %d\nЩит: %d" % [enemy.health, enemy.shield]
	$test_ui/PlayerStats.text = player_str
	$test_ui/EnemyStats.text = enemy_str

func update_energy():
	$test_ui/energy.text = "Энергия %d" % player.energy

func update_log(new_line: String):
	logs += "\n%s" % new_line
	$test_ui/log.text = logs

func update_die_btn(i: int, text: String):
	$test_ui/HBoxContainer.get_children()[i].text = text
	
func update_enemy_intention(text):
	$test_ui/intention.text = text

func die_roll(i: int):
	var result = battle.process_player_roll(i)
	if not result.is_empty():
		update_log("Кость %d: выпало %d" % [i + 1, result["face"]])
		if result["has_effect"]:
			update_log("Эффект: %s" % result["effect"]["description"])
		update_die_btn(i, "%d %s" % [result["face"], result["effect"]["type"]])
	update_stats()
	update_energy()

func apply():
	# Ход врага
	enemy.start_round()
	battle.process_enemy_turn()
	update_log("Враг: %s" % enemy.intention["description"])
	
	# Следующий раунд
	next_round()

func next_round():
	battle.start_round()
	update_log("=== РАУНД %d ===" % battle.current_round)
	update_energy()
	update_stats()
	update_enemy_intention(enemy.intention["description"])
