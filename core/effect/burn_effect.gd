## Реализация эффекта горения[br]
## Подробнее смотрите [BaseEffect]
class_name BurnEffect
extends BaseEffect

func _init(new_effect_value: int = 0):
	name = 'Горение'
	tag = 'burn'
	order = 1
	value = new_effect_value
	duration = 3

func apply(target: Entity) -> int:
	target.take_damage(value)
	Global.update_log.emit("%s %s" % [target.name, _get_log_text()])
	return value

func stack(new_effect: BaseEffect):
	value += new_effect.value
	duration = 3

func tick():
	duration = max(0, duration-1)

func _get_log_text() -> String:
	return "получил %d урона горением" % value
