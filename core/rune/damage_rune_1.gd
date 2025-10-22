class_name DamageRune1
extends BaseRune
func _init():
	self.name = "Урон I"
	self.rune_type = "damage"
	self.description = "Руна урона: 1*face"
	self.tags = ["damage", "offense", "shop", "chest", "common"]

func calculate(face: int):
	return face

func apply(source: Entity, target: Entity, face: int):
	target.take_damage(source, calculate(face))
	GameManager.update_log.emit("%s %s" % [target.name, _get_log_text(face)])

func get_description(face: int):
	return "Урон: %d" % calculate(face)

func _get_log_text(face):
	return " получил %d урона" % calculate(face)
