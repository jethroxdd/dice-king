class_name Die
extends RefCounted

var sides: int
var faces: Array = [] # Массив эффектов для каждой грани

func _init(num_sides: int):
	sides = num_sides
	faces.resize(sides)
	# Инициализируем пустыми эффектами
	for i in range(sides):
		faces[i] = null

func set_face(face_number: int, effect: Dictionary):
	if face_number >= 0 and face_number < sides:
		faces[face_number] = effect

func roll() -> Dictionary:
	var result = randi() % sides
	var effect = faces[result]
	
	return {
		"face": result + 1, # Показываем 1-based результат
		"effect": effect,
		"has_effect": effect != null
	}

func get_sides() -> int:
	return sides
