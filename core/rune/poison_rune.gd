class_name PoisonRune
extends BaseRune
func _init():
    self.name = "Яд"
    self.rune_type = "shield"
    self.description = "Накладывает яд: 2"
    self.tags = ["shield", "defence", "shop", "chest", "common"]

func calculate(_face: int):
    return 2

func apply(_sorce: Entity, target: Entity, face: int):
    target.add_effect(PoisonEffect.new(calculate(face)))

func get_description(face: int):
    return "Яд: %d" % calculate(face)

func get_log(face):
    return "Наложено %d яда" % calculate(face)