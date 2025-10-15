class_name DamageRune1
extends BaseRune
func _init():
    self.name = "Урон I"
    self.rune_type = "damage"
    self.description = "Руна урона: 1*face"
    self.tags = ["damage", "offense", "shop", "chest", "common"]

func calculate(face: int):
    return face

func apply(_sorce: Entity, target: Entity, face: int):
    target.take_damage(calculate(face))

func get_description(face: int):
    return "Урон: %d" % calculate(face)

func get_log(face):
    return "Нанесено %d урона" % calculate(face)