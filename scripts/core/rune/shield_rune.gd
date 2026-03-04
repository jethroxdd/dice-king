class_name ShieldRune
extends BaseRune
func _init():
	self.name = "Щит"
	self.rune_type = "shield"
	self.description = "Дает щит: 1+face"
	self.tags = ["shield", "defence", "shop", "chest", "common"]
	self.icon_path = "res://assets/sprites/icons/shield.png"

func calculate(face: int):
	return face + 1

func apply(source: Entity, _target: Entity, face: int):
	source.take_shield(calculate(face))
	EventBus.update_log.emit("%s %s" % [source.name, _get_log_text(face)])

func get_description(face: int):
	return "Щит: %d" % calculate(face)

func _get_log_text(face):
	return "получил %d щита" % calculate(face)
