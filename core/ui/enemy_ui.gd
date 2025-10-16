extends Control

var enemy: Enemy
signal selected

func _ready() -> void:
	update_stats()
	update_intention()
	Global.target_selected.connect(unselect)
	$Button.pressed.connect(select)
	
func update_stats():
	var enemy_str = "Здровье: %d\nЩит: %d\nЭффекты:\n%s" % [enemy.health, enemy.shield, enemy.get_effects_string()]
	$StatsRLabel.text = enemy_str

func update_intention():
	$IntentionRLabel.text = enemy.intention["description"]

func unselect():
	$SelectedPanel.visible = false

func select():
	Global.target_selected.emit()
	selected.emit()
	$SelectedPanel.visible = true
