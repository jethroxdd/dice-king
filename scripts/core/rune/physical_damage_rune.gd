@warning_ignore_start("unused_parameter")
class_name PhysicalDamageRune
extends BaseRune
func _init():
	self.name = "Физический урон"
	self.rune_type = "physical_damage"
	self.description = "Руна физ. урона равного стороне."
	self.tags = ["physical_damage", "offense", "shop", "chest", "common"]
	self.icon_path = "res://assets/sprites/icons/physical_damage.png"

func calculate(value: int):
	return value

func apply(source: Entity, target: Entity, value: int):
	target.take_damage(source, calculate(value))
	EventBus.update_log.emit("%s %s" % [target.name, _get_log_text(value)])

func get_description(value: int):
	return "Физ. урон: %d" % calculate(value)

func _get_log_text(value):
	return " получил %d физ. урона" % calculate(value)
