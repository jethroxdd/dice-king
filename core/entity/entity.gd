## [b]Класс Entity[/b][br]
## Базовый класс для всех игровых сущностей с системой здоровья, щитов и эффектов.[br]
## Наследует: [RefCounted]
class_name Entity
extends RefCounted

## [b]Имя сущности[/b][br]
## Используется для идентификации и отображения в интерфейсе
var name: String

## [b]Максимальное здоровье[/b][br]
## Показывает максимально возможное значение здоровья сущности
var max_health: int

## [b]Текущее здоровье[/b][br]
## Текущий уровень здоровья. При достижении 0 сущность считается уничтоженной
var health: int

## [b]Щит[/b][br]
## Поглощает входящий урон перед вычетом из здоровья[br]
## [i]По умолчанию: 0[/i]
var shield: int = 0

## [b]Массив активных эффектов[/b][br]
## Содержит все текущие эффекты типа [BaseEffect]
var effects: Array[BaseEffect] = []

var is_alive: bool:
	get:
		return health > 0

## [b]Конструктор сущности[/b][br]
## Создает новую сущность с указанными параметрами[br]
## [br]
## [b]Параметры:[/b][br]
## [param entity_name] - Имя сущности[br]
## [param initial_health] - Начальное и максимальное здоровье
func _init(entity_name: String, initial_health: int):
	name = entity_name
	max_health = initial_health
	health = initial_health

## [b]Получить урон с учетом щита[/b][br]
## Вычитает урон сначала из щита, затем из здоровья[br]
## [br]
## [b]Параметры:[/b][br]
## [param damage] - Величина входящего урона[br]
## [br]
## [b]Возвращает:[/b] Фактический полученный урон после учета щита
func take_damage(source: Entity, damage: int) -> int:
	var actual_damage = max(0, damage - shield)
	shield = max(0, shield - damage)
	health -= actual_damage
	return actual_damage

## [b]Получить чистый урон[/b][br]
## Наносит урон напрямую здоровью, игнорируя щит[br]
## [br]
## [b]Параметры:[/b][br]
## [param damage] - Величина чистого урона[br]
## [br]
## [b]Возвращает:[/b] Величину нанесенного урона
func take_true_damage(damage: int) -> int:
	health -= damage
	return damage

## [b]Добавить щит[/b][br]
## Увеличивает текущее значение щита[br]
## [br]
## [b]Параметры:[/b][br]
## [param value] - Величина добавляемого щита[br]
## [br]
## [b]Возвращает:[/b] Величину добавленного щита
func take_shield(value: int) -> int:
	shield += value
	return value

## [b]Восстановить здоровье[/b][br]
## Увеличивает здоровье, но не выше максимального[br]
## [br]
## [b]Параметры:[/b][br]
## [param amount] - Величина восстановления
func heal(amount: int):
	health = min(health + amount, max_health)

## [b]Проверить наличие щита[/b][br]
## [br]
## [b]Возвращает:[/b] [code]true[/code] если щит активен (>0), иначе [code]false[/code]
func has_shield() -> bool:
	return shield > 0

## [b]Добавить эффект[/b][br]
## Добавляет новый эффект или увеличивает стаки существующего[br]
## [br]
## [b]Параметры:[/b][br]
## [param new_effect] - Экземпляр [Class]BaseEffect[/Class] для добавления
func add_effect(new_effect: BaseEffect):
	for effect in effects:
		if effect.name == new_effect.name:
			effect.stack(new_effect)
			return
	
	effects.append(new_effect)

## [b]Удалить эффект[/b][br]
## Удаляет конкретный эффект из массива[br]
## [br]
## [b]Параметры:[/b][br]
## [param effect] - Экземпляр [Class]BaseEffect[/Class] для удаления
func remove_effect(effect: BaseEffect):
	effects.erase(effect)

## [b]Очистить все эффекты[/b][br]
## Полностью очищает массив активных эффектов
func clear_effects():
	effects.clear()

## [b]Обновить эффекты[/b][br]
## Уменьшает длительность всех эффектов и удаляет завершившиеся
func tick_effects(applyed_effects: Array[BaseEffect]):
	var expired_effects: Array[BaseEffect] = []
	
	for effect in applyed_effects:
		effect.tick()
		if effect.is_ended:
			expired_effects.append(effect)
	
	for effect in expired_effects:
		effects.erase(effect)

## [b]Применить эффекты[/b][br]
## Активирует все эффекты и обновляет их состояние[br]
## [br]
## [b]Возвращает:[/b] Словарь с типами эффектов и их значениями
func apply_effects(order: int):
	var applyed_effects: Array[BaseEffect] = []
	for effect in effects:
		if effect.order == order:
			effect.apply(self)
			applyed_effects.append(effect)
	tick_effects(applyed_effects)

## [b]Получить строку эффектов[/b][br]
## Формирует текстовое представление всех активных эффектов[br]
## [br]
## [b]Возвращает:[/b] Строку с перечислением эффектов через запятую
func get_effects_string() -> String:
	var effect_strings: Array[String] = []
	for effect in effects:
		effect_strings.append(effect._to_string())
	return "\n".join(PackedStringArray(effect_strings))

## [b]Получить случайны элемент массива[/b][br]
## [br]
## [b]Возвращает:[/b] случайный элемент массива
func _get_random_item(arr: Array):
	if arr.size() == 0:
		return null
	return arr[randi() % arr.size()]
