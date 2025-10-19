class_name Intention
extends  RefCounted

var type: String
var value: int
var text: String
var log_text: String

func _init(i_type: String, i_value: int, i_text: String, i_log_text: String):
	type = i_type
	value = i_value
	text = i_text
	log_text = i_log_text

static func default() -> Intention:
	return Intention.new("none", 0, "none", "none")
