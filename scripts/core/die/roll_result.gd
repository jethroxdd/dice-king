class_name RollResult
extends RefCounted

var face_idx: int
var value: int
var rune: BaseRune

func _init(face_index: int, face_value: int, face_rune: BaseRune) -> void:
	face_idx = face_index
	value = face_value
	rune = face_rune

static func default() -> RollResult:
	return RollResult.new(-1, -1, EmptyRune.new())

func is_default():
	return face_idx == -1
