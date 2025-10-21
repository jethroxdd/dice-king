class_name RollResult
extends RefCounted

var face: int
var rune: BaseRune

func _init(roll_face: int, face_rune: BaseRune) -> void:
	face = roll_face
	rune = face_rune

static func default() -> RollResult:
	return RollResult.new(0, EmptyRune.new())

func is_default():
	return face == 0
