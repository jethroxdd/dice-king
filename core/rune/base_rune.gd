## Базовый класс для всех рун в системе.[br]
class_name BaseRune
extends RefCounted

## Имя для отображения в UI
var name: String

##  Уникальное имя руны
var rune_type: String

## Базовое описание эффекта руны
var description: String

## Массив тегов для гибкой классификации
var tags: Array = []

## [b]Абстрактный метод:[/b] Рассчитывает числовой эффект руны[br]
## [br]
## [b]Параметры:[/b][br]
## [param _face] - значение на кубике[br]
## [br]
## [b]Возвращает:[/b] числовой результат активации[br]
## [br]
## [i]Переопределите этот метод в дочерних классах[/i][br]
func calculate(_face: int):
	push_error("calculate() is not implemented")

## [b]Абстрактный метод:[/b] Применяет эффект руны к сущностям[br]
## [br]
## [b]Параметры:[/b][br]
## [param _sorce] - сущность-активатор ([member Entity])[br]
## [param _target] - сущность-цель ([member Entity])[br]
## [param _face] - значение на кубике[br]
## [br]
## [i]Переопределите этот метод в дочерних классах[/i][br]
func apply(_sorce: Entity, _target: Entity, _face: int):
	push_error("calculate() is not implemented")

## Генерирует описание с учетом значения кубика[br]
## [br]
## [b]Параметры:[/b][br]
## [param _face] - значение на кубике[br]
## [br]
## [b]Возвращает:[/b] локализованную строку с подставленными значениями
func get_description(_face: int) -> String:
	return ""

## Создает запись в логе действий[br]
## [br]
## [b]Параметры:[/b][br]
## [param _face] - значение на кубике[br]
## [br]
## [b]Возвращает:[/b] текстовую запись для игрового лога
func get_log(_face) -> String:
	return ""