extends Control
class_name TooltipDieFace

func set_data(value, icon_path):
	$Icon/ValueLabel.text = str(value)
	# Загружаем текстуру
	$Icon.texture = load(icon_path)

func active(is_active: bool):
	if is_active:
		$Icon.modulate = Color(1, 1, 1, 1)
	else:
		$Icon.modulate = Color(0.38, 0.38, 0.38, 1)
