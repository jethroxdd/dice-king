extends Control
class_name Tooltip

func _process(_delta: float) -> void:
	if Methods.is_mouse_over_control(self):
		hide()
		Global.is_die_tooltip_showed = false

func set_data(data: Array):
	var die_scene: PackedScene
	var sides = data[0]
	match(sides):
		4:
			die_scene = load("res://scenes/UI/ToolTip/dice/tooltip_d4.tscn")
		6:
			die_scene = load("res://scenes/UI/ToolTip/dice/tooltip_d6.tscn")
		_:
			return
	var tooltip_die = die_scene.instantiate()
	add_child(tooltip_die)
	tooltip_die.set_data(data)
