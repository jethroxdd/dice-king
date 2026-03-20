@warning_ignore_start("unused_parameter")
class_name EmptyRune
extends BaseRune
func _init():
	self.name = "Пусто"
	self.rune_type = "empty"
	self.description = "Empty rune."
	self.tags = ["empty"]
	self.icon_path = "res://assets/sprites/icons/empty.png"

func calculate(value: int):
	return 0

func apply(source: Entity, target: Entity, value: int):
	EventBus.update_log.emit(_get_log_text(value))

func get_description(value: int):
	return "Пустой слот руны"

func _get_log_text(value) -> String:
	return "Ничего не произошло"
