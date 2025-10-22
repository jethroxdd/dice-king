class_name EmptyRune
extends BaseRune
func _init():
	self.name = "Пусто"
	self.rune_type = "empty"
	self.description = "Пустой слот руны"
	self.tags = ["empty"]

func calculate(_face: int):
	return 0

func apply(_source: Entity, _target: Entity, _face: int):
	GameManager.update_log.emit(_get_log_text(_face))

func get_description(_face: int):
	return "Пустой слот руны"

func _get_log_text(_face) -> String:
	return "Ничего не произошло"
