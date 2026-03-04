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

## Относительный путь к фалу иконки
var icon_path = ""

## [b]Абстрактный метод:[/b] Рассчитывает числовой эффект руны[br]
## [br]
## [b]Параметры:[/b][br]
## [param _face] - номер стороны (от 0 до n-1)[br]
## [br]
## [b]Возвращает:[/b] [param int] числовой результат активации[br]
## [br]
## [i]Переопределите этот метод в дочерних классах[/i][br]
func calculate(_face: int):
	push_error("calculate() is not implemented")

## [b]Абстрактный метод:[/b] Применяет эффект руны к сущностям[br]
## [br]
## [b]Параметры:[/b][br]
## [param _sorce] - сущность-активатор ([member Entity])[br]
## [param _target] - сущность-цель ([member Entity])[br]
## [param _face] - номер стороны (от 0 до n-1)[br]
## [br]
## [i]Переопределите этот метод в дочерних классах[/i][br]
func apply(_source: Entity, _target: Entity, _face: int):
	push_error("calculate() is not implemented")

## Генерирует описание с учетом значения кубика[br]
## [br]
## [b]Параметры:[/b][br]
## [param _face] - номер стороны (от 0 до n-1)[br]
## [br]
## [b]Возвращает:[/b] локализованную строку с подставленными значениями
func get_description(_face: int) -> String:
	return ""

## Создает запись в логе действий[br]
## [br]
## [b]Параметры:[/b][br]
## [param _face] - номер стороны (от 0 до n-1)[br]
## [br]
## [b]Возвращает:[/b] текстовую запись для игрового лога
func _get_log_text(_face) -> String:
	return ""

## Возвращает строчку для отображения подсказки[br]
## [br]
## [b]Параметры:[/b][br]
## [param _face] - номер стороны (от 0 до n-1)[br]
## [br]
## [b]Возвращает:[/b] Массив из двух элементов: значения руны и пути к иконке руны
func get_tooltip_data(face) -> Array:
	return [calculate(face), icon_path]
