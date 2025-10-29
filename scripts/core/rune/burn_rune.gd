class_name BurnRune
extends BaseRune
func _init():
	self.name = "Горение"
	self.rune_type = "burn"
	self.description = "Накладывает грение: 1*face"
	self.tags = ["shield", "defence", "shop", "chest", "common"]

func calculate(face: int):
	return face

func apply(_source: Entity, target: Entity, face: int):
		target.add_effect(BurnEffect.new(calculate(face)))
		EventBus.update_log.emit("%s %s" % [target.name, _get_log_text(face)])

func get_description(face: int):
	return "Горение: %d" % calculate(face)

func _get_log_text(face):
	return "получил %d стаков горения" % calculate(face)
