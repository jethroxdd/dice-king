class_name BaseEffect
extends RefCounted


# Base properties
var name: String = "base_effect"
var value: int = 0
var duration: int = 0
var priority: int = Enums.EffectPriority.GOOD
var color: Color = Color.WHITE

# Computed property
var is_ended: bool:
    get: return duration <= 0

func apply(_target: Entity) -> void:
    push_error("apply() not implemented in derived class")

func stack(new_effect: BaseEffect) -> void:
    duration += new_effect.duration

func tick() -> void:
    if duration > 0:
        duration -= 1

func _to_string() -> String:
    return "%s [%d|%d]" % [name, value, duration]