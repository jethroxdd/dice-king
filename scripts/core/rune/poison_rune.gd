@warning_ignore_start("unused_parameter")
class_name PoisonRune
extends BaseRune
func _init():
	self.name = "Яд"
	self.rune_type = "poison"
	self.description = "Накладывает яд равный стороне."
	self.tags = ["poison", "offense", "shop", "chest", "epic"]
	self.icon_path = "res://assets/sprites/icons/poison.png"

func calculate(value: int):
	return value

func apply(source: Entity, target: Entity, value: int):
		target.add_effect(PoisonEffect.new(calculate(value)))
		EventBus.update_log.emit("%s %s" % [target.name, _get_log_text(value)])

func get_description(value: int):
	return "Яд: %d" % calculate(value)

func _get_log_text(value):
	return "получил %d стаков яда" % calculate(value)
