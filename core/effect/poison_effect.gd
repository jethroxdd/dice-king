## Реализация эффекта яда[br]
## Подробнее смотрите [BaseEffect]
class_name PoisonEffect
extends BaseEffect

func _init(effect_value: int = 0):
	self.name = 'Яд'
	self.effect_type = 'poison'
	self.value = effect_value
	self.duration = effect_value

func apply(target: Entity) -> int:
	target.take_true_damage(value)
	return value

func stack(new_effect: BaseEffect):
	self.value += new_effect.value
	self.duration = self.value

func tick():
	self.value = max(0, value-1)
	self.duration = value
