class_name BattleManager
extends RefCounted

var player: Player
var enemy: Enemy
var current_round: int = 0

func _init(player_ref: Player, enemy_ref: Enemy):
	player = player_ref
	enemy = enemy_ref

func start_round():
	current_round += 1
	player.start_round()
	enemy.intention = enemy.make_move()

func process_player_roll(die_index: int) -> Dictionary:
	var roll_result = player.roll_die(die_index)
	if roll_result.is_empty():
		return {}
	
	# Применяем эффект броска
	apply_effect(player, enemy, roll_result["effect"])
	return roll_result

func process_enemy_turn() -> Dictionary:
	var result = enemy.intention
	if result.is_empty():
		return {}
	
	# Применяем эффект действия
	apply_effect(enemy, player, result)
	return result

func apply_effect(sorce, target, effect: Dictionary):
	if effect == null:
		return
	
	match effect["type"]:
		"damage":
			target.take_damage(effect["value"])
		"shield":
			sorce.shield += effect["value"]
		"heal":
			sorce.heal(effect["value"])
		# Добавьте другие типы эффектов по необходимости

func is_battle_over() -> bool:
	return player.health <= 0 or enemy.health <= 0

func get_winner() -> String:
	if player.health <= 0:
		return "enemy"
	elif enemy.health <= 0:
		return "player"
	return ""
