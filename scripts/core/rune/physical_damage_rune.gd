class_name PhysicalDamageRune
extends BaseRune
func _init():
	self.name = "Физический урон"
	self.rune_type = "physical_damage"
	self.description = "Руна физ. урона: 1*face"
	self.tags = ["physical_damage", "offense", "shop", "chest", "common"]
	self.icon_path = "res://assets/sprites/icons/physical_damage.png"

func calculate(face: int):
	return face+1

func apply(source: Entity, target: Entity, face: int):
	target.take_damage(source, calculate(face))
	EventBus.update_log.emit("%s %s" % [target.name, _get_log_text(face)])

func get_description(face: int):
	return "Физ. урон: %d" % calculate(face)

func _get_log_text(face):
	return " получил %d физ. урона" % calculate(face)
