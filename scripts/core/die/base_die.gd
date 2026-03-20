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

## Массив значений на сторонах
var values: Array[int] = []

var _faces: Array[DieFace] = []

## Массив оставшихся рун
var availible: Array = []

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
	if not num_sides in [4, 6, 8, 10, 12, 20]:
		push_error("Incorrect die size")
	_sides = num_sides
	_faces.resize(sides)
	
	# Инициализируем стороны
	for i in range(sides):
		# Добавляем стороны с рунами из списка
		# Заполняем пустыми, если список короче кол-ва сторон или он пуст
		_faces[i] = DieFace.new(i, i+1, i+1, faces_list[i]) if i < len(faces_list) and not faces_list.is_empty() else DieFace.new(i, i+1, i+1, EmptyRune.new())
	reset_availible()

## Бросить кость[br]
## [br]
## [b]Возвращает:[/b] [code]RollResult[/code] - Класс данных с результатами броска:[br]
func roll() -> RollResult:
	# Случайная грань из доступных
	var face_idx = get_rand_availible()
	var rune = _faces[face_idx].rune
	var value = _faces[face_idx].value
	# Убрать только что выпавшую сторону из списка доступных
	remove_availible(face_idx)
	# Если доступные стороны кончились - восстановить его
	if availible.is_empty():
		reset_availible()
	return RollResult.new(face_idx, value, rune)

## Получить количество граней кости[br]
## [br]
## [b]Возвращает:[/b] [code]int[/code] - количество граней
func get_sides() -> int:
	return _sides

func get_rand_availible() -> int:
	return availible[randi() % len(availible)]

func add_availible(idx):
	if idx in availible:
		push_warning("Попытка добавить существующую доступную сторону")
	availible.append(idx)

func remove_availible(idx):
	if not idx in availible:
		push_error("Выбранной стороны нет в списке доступных")
	availible.erase(idx)

## Сделать доступными все стороны
func reset_availible():
	availible = range(sides)

## Вычисляемое свойство[br]
## Возвращает: кол-во сторон и [class TooltipData][br].
func get_tooltip_data() -> Array:
	var tooltip_data: TooltipData = TooltipData.new()
	for face in _faces:
		tooltip_data.add_face(face.idx, face.idx in availible, face.rune.calculate(face.value), face.rune.icon_path)
	return [sides, tooltip_data]
