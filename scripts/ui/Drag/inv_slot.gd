# InvSlot.gd
class_name InvSlot
extends BaseSlot

# Специфичная для InvSlot логика (например, отображение границы при наведении)
func _process(_delta: float) -> void:
	$Border.visible = Methods.is_mouse_over_control(self)
