## Реализация эффекта яда[br]
## Подробнее смотрите [BaseEffect]
class_name PoisonEffect
extends BaseEffect

func _init(new_effect_value: int = 0):
	name = 'Яд'
	tag = 'poison'
	order = 1
	value = new_effect_value
	duration = new_effect_value

func apply(target: Entity) -> int:
	target.take_true_damage(value)
	EventBus.update_log.emit("%s %s" % [target.name, _get_log_text()])
	return value

func stack(new_effect: BaseEffect):
	value += new_effect.value
	duration = value

func tick():
	value = max(0, value-1)
	duration = value

func _get_log_text() -> String:
	return "получил %d урона ядом" % value
