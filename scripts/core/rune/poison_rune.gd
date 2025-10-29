class_name PoisonRune
extends BaseRune
func _init():
	name = "Яд"
	rune_type = "poison"
	description = "Накладывает яд: 2"
	tags = ["poison", "offense", "shop", "chest", "epic"]

func calculate(_face: int):
	return 2

func apply(_source: Entity, target: Entity, face: int):
		target.add_effect(PoisonEffect.new(calculate(face)))
		EventBus.update_log.emit("%s %s" % [target.name, _get_log_text(face)])

func get_description(face: int):
	return "Яд: %d" % calculate(face)

func _get_log_text(face):
	return "получил %d стаков яда" % calculate(face)
