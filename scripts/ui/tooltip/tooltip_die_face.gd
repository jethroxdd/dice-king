extends Control
class_name TooltipDieFace

func set_data(value, icon_path):
	$Icon/Value/ValueLabel.text = str(value)
	# Загружаем текстуру
	$Icon.texture = load(icon_path)

func active(is_active: bool):
	if is_active:
		$Active.visible = false
	else:
		$Active.visible = true
