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
	_reset_remaining_faces()

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
	return RollResult.new(result+1, rune)

## Получить количество граней кости[br]
## [br]
## [b]Возвращает:[/b] [code]int[/code] - количество граней
func get_sides() -> int:
	return _sides

## Сделать доступными все стороны
func _reset_remaining_faces():
	for i in range(sides):
		remain_faces.append(i)

## Вычисляемое свойство[br]
## Возвращает текстовое описание всех граней кости в формате, пригодном для подсказки в UI.[br]
## Каждая строка содержит описание руны на соответствующей грани.
var tooltip_text: String:
	get:
		var text = ""
		for i in range(sides):
			var temp = "%d: %s\n" % [i, faces[i].get_description(i+1)]
			text += temp if i in remain_faces else "-\n"
		return text
