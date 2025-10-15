class_name ShieldRune1
extends BaseRune
func _init():
    self.name = "Щит  I"
    self.rune_type = "shield"
    self.description = "Дает щит: 1+face"
    self.tags = ["shield", "defence", "shop", "chest", "common"]

func calculate(face: int):
    return face + 1

func apply(sorce: Entity, _target: Entity, face: int):
    sorce.take_shield(calculate(face))

func get_description(face: int):
    return "Щит: %d" % calculate(face)

func get_log(face):
    return "Получено %d щита" % calculate(face)