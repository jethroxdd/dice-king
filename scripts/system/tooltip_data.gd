extends RefCounted

class_name TooltipData
##Тип данных для формирования подсказки к кубикам.[br]
##[param faces] - состоит из массива [code]TooltipFaceData[/code]:[br]
##[code]TooltipFaceData[/code] имеет поля:[br]
##[param face] номер стороны кубика[br]
##[param active] доступна ли эта сторона[br]
##[param value] значение руны этой стороны[br]
##[param icon_path] путь к иконке этой стороны[br]

class TooltipFaceData:
	var face: int
	var active: bool
	var value: int
	var icon_path: String

	func _init(face_, active_, value_, icon_path_):
		face = face_
		active = active_
		value = value_
		icon_path = icon_path_

var faces: Array[TooltipFaceData]

func _init() -> void:
	faces = []

func add_face(face_, active_, value_, icon_path_):
	var tooltip_face = TooltipFaceData.new(face_, active_, value_, icon_path_)
	faces.append(tooltip_face)
