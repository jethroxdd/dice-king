## [b]BaseEffect[/b] - базовый класс для всех эффектов в системе.[br]
##[br]
## Наследуется от [RefCounted] и служит основой для создания различных эффектов, 
## которые могут применяться к объектам типа [Entity]. Содержит базовую логику 
## длительности, применения и описания эффектов.[br]

class_name BaseEffect
extends RefCounted

## Название эффекта для отображения в UI
var name: String = "base effect"

## Тип эффекта для группировки и идентификации
var effect_type: String = ""

## Сила/значение эффекта (урон, бонус и т.д.)
var value: int = 0

## Длительность эффекта в тиках (0 - мгновенный эффект)
var duration: int = 0

## [b]is_ended[/b] - вычисляемое свойство[br]
## Возвращает true, если эффект завершился (длительность ≤ 0)
var is_ended: bool:
	get: return duration <= 0

## Применяет текщий эффект к [param _target][br]
##[br]
## [b]Параметры:[/b][br]
## [param _target] - целевая сущность [Entity][br]
##[br]
## [b]Возвращает:[/b][br]
## [code]int[/code] - результат применения эффекта[br]
##[br]
## [i]Переопределите этот метод в дочерних классах[/i][br]
func apply(_target: Entity) -> int:
	push_error("apply() is not implemented")
	return 0
## Логика складывания текущего эффекта с  [param _new_effect][br]
##[br]
## [b]Параметры:[/b][br]
## [param _new_effect] - новый эффект [BaseEffect] для объединения[br]
##[br]
## [i]Переопределите этот метод в дочерних классах[/i][br]
func stack(_new_effect: BaseEffect):
	push_error("stack() is not implemented")

## Обновление/уменьшение эффекта
##[br]
## [i]Переопределите этот метод в дочерних классах[/i][br]
func tick():
	push_error("tick() is not implemented")

## [b]Возвращает:[/b][br]
## [code]String[/code] - текстовое описание эффекта[br]
##[br]
## [i]Переопределите этот метод в дочерних классах[/i][br]
func get_description() -> String:
	push_error("get_description() is not implemented")
	return "description example"

## [b]Возвращает:[/b][br]
## [code]String[/code] - строка в формате "название [значение|длительность]"
func _to_string() -> String:
	return "%s [%d|%d]" % [name, value, duration]