extends Control

var enemy: Enemy
signal selected

func _ready() -> void:
	update_stats()
	update_intention()
	EventBus.target_selected.connect(unselect)
	$Button.pressed.connect(select)
	$NameLabel.text = enemy.name
	
func update_stats():
	var stats = "Здровье: %d\nЩит: %d\nЭффекты:" % [enemy.health, enemy.shield]
	$StatsRLabel.text = stats
	$EffectsLabel.text = enemy.get_effects_string()

func update_intention():
	$IntentionRLabel.text = enemy.intention.text

func unselect():
	$SelectedPanel.visible = false

func select():
	EventBus.target_selected.emit()
	selected.emit()
	$SelectedPanel.visible = true
