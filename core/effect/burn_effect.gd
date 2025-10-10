class_name BurnEffect
extends BaseEffect
const BaseEffect = preload("res://core/effect/base_effect.gd")

func _init(burn_value: int = 0, burn_duration: int = 3):
    name = "burn"
    value = burn_value
    duration = burn_duration
    priority = Enums.EffectPriority.BAD
    color = Color.ORANGE

func apply(target: Entity) -> void:
    target.take_true_damage(value)

func stack(new_effect: BaseEffect) -> void:
    # Average stacking: (current + new) / 2
    value = (value + new_effect.value) / 2
    duration += new_effect.duration