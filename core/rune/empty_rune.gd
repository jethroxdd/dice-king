class_name EmptyRune
extends BaseRune
func _init():
	self.name = "Пусто"
	self.rune_type = "empty"
	self.description = "Пустой слот руны"
	self.tags = ["empty"]

func calculate(_face: int):
	return 0

func apply(_sorce: Entity, _target: Entity, _face: int):
	pass

func get_description(_face: int):
	return "Пустой слот руны"

func get_log(_face):
	return "Ничего не произошло"
