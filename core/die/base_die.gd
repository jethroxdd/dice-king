## [b]Die[/b] - класс игральной кости с рунами на гранях.[br]
##[br]
## Наследуется от [RefCounted] и представляет собой игральную кость с заданным 
## количеством граней, где каждая грань содержит руну
class_name Die
extends RefCounted

## Количество граней кости
var sides: int

## Массив рун на каждой грани
var faces: Array[BaseRune] = [] # Руны на каждой грани

## Конструктор кости[br]
## [br]
## [b]Параметры:[/b][br]
## [param num_sides] - количество граней кости[br]
## [param faces_list] - массив рун для инициализации граней (опционально)[br]
##[br]
## [b]Примечание:[/b][br]
## Если [param faces_list] короче чем [param num_sides], оставшиеся грани заполняются [EmptyRune][br]
## Если [param faces_list] пуст, все грани инициализируются [EmptyRune]
func _init(num_sides: int, faces_list: Array = []):
	sides = num_sides
	faces.resize(sides)
	# Инициализируем пустыми эффектами
	for i in range(sides):
		faces[i] = faces_list[i] if i < len(faces_list) and not faces_list.is_empty() else EmptyRune.new()

## Бросить кость[br]
## [br]
## [b]Возвращает:[/b][br]
## [code]Dictionary[/code] - словарь с результатами броска:[br]
##   - [code]"face"[/code]: номер выпавшей грани (1-based)[br]
##   - [code]"rune"[/code]: руна на выпавшей грани[br]
func roll() -> Dictionary:
	var result = randi() % sides
	var rune = faces[result]
	
	return {
		"face": result + 1, # Показываем 1-based результат
		"rune": rune
	}

## Получить количество граней кости[br]
## [br]
## [b]Возвращает:[/b][br]
## [code]int[/code] - количество граней
func get_sides() -> int:
	return sides

## Вычисляемое свойство[br]
## Возвращает текстовое описание всех граней кости в формате, пригодном для подсказки в UI.[br]
## Каждая строка содержит описание руны на соответствующей грани.
var tooltip_text: String:
	get:
		var text = ""
		for i in range(sides):
			text += "%s\n" % faces[i].get_description(i)
		return text
