@warning_ignore_start("unused_parameter")
class_name ShieldRune
extends BaseRune
func _init():
	self.name = "Щит"
	self.rune_type = "shield"
	self.description = "Дает щит: 1+face"
	self.tags = ["shield", "defence", "shop", "chest", "common"]
	self.icon_path = "res://assets/sprites/icons/shield.png"

func calculate(value: int):
	return value

func apply(source: Entity, target: Entity, value: int):
	source.take_shield(calculate(value))
	EventBus.update_log.emit("%s %s" % [source.name, _get_log_text(value)])

func get_description(value: int):
	return "Щит: %d" % calculate(value)

func _get_log_text(value):
	return "получил %d щита" % calculate(value)
