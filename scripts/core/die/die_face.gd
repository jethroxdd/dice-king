extends  RefCounted
class_name DieFace

var idx: int
var value: int
var default: int
var rune: BaseRune

func _init(idx_: int, value_: int, default_: int, rune_: BaseRune) -> void:
	idx = idx_
	value = value_
	default = default_
	rune = rune_
