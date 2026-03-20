@warning_ignore_start("unused_parameter")
class_name BurnRune
extends BaseRune
func _init():
	self.name = "Горение"
	self.rune_type = "burn"
	self.description = "Накладывает грение равное стороне."
	self.tags = ["shield", "defence", "shop", "chest", "common"]
	self.icon_path = "res://assets/sprites/icons/burn.png"

func calculate(value: int):
	return value

func apply(source: Entity, target: Entity, value: int):
		target.add_effect(BurnEffect.new(calculate(value)))
		EventBus.update_log.emit("%s %s" % [target.name, _get_log_text(value)])

func get_description(face: int):
	return "Горение: %d" % calculate(face)

func _get_log_text(face):
	return "получил %d стаков горения" % calculate(face)
