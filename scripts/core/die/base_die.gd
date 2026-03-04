## [b]Die[/b] - класс игральной кости с рунами на гранях.[br]
## [br]
## Наследуется от [RefCounted] и представляет собой игральную кость с заданным 
## количеством граней, где каждая грань содержит руну
class_name Die
extends RefCounted

# Приватное поле количества граней
var _sides: int
## Количество граней кости
var sides: int:
	get:
		return get_sides()

## Массив рун на каждой грани
var faces: Array[BaseRune] = [] # Руны на каждой грани
## Массив оставшихся рун
var remain_faces: Array[int] = []

## Конструктор кости[br]
## [br]
## [b]Параметры:[/b][br]
## [param num_sides] - количество граней кости[br]
## [param faces_list] - массив рун для инициализации граней (опционально)[br]
## [br]
## [b]Примечание:[/b][br]
## Если [param faces_list] короче чем [param num_sides], оставшиеся грани заполняются [EmptyRune][br]
## Если [param faces_list] пуст, все грани инициализируются [EmptyRune]
func _init(num_sides: int, faces_list: Array = []):
	_sides = num_sides
	faces.resize(sides)
	# Инициализируем пустыми эффектами
	for i in range(sides):
		faces[i] = faces_list[i] if i < len(faces_list) and not faces_list.is_empty() else EmptyRune.new()
	reset_remaining_faces()

## Бросить кость[br]
## [br]
## [b]Возвращает:[/b] [code]RollResult[/code] - Класс данных с результатами броска:[br]
func roll() -> RollResult:
	# Случайная грань из доступных
	var result = remain_faces[randi() % len(remain_faces)]
	var rune = faces[result]
	# Убрать только что выпавшую сторону из списка доступных
	remain_faces.erase(result)
	# Если доступные стороны кончились - восстановить его
	if remain_faces.is_empty():
		_reset_remaining_faces()
	return RollResult.new(result, rune)

## Получить количество граней кости[br]
## [br]
## [b]Возвращает:[/b] [code]int[/code] - количество граней
func get_sides() -> int:
	return _sides

## Сделать доступными все стороны
func reset_remaining_faces():
	for i in range(sides):
		remain_faces.append(i)

## Вычисляемое свойство[br]
## Возвращает: кол-во сторон и [class TooltipData][br].
func get_tooltip_data() -> Array:
	var tooltip_data: TooltipData = TooltipData.new()
	var i = 0
	for face in faces:
		tooltip_data.add_face(i, i in remain_faces, face.calculate(i), face.icon_path)
		i += 1
	return [sides, tooltip_data]
