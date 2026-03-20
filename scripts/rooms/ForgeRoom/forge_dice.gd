@tool
extends Control
class_name ForgeDice

enum DiceTypes{D4, D6, D8, D10, D12, D20}

@export var die_type: DiceTypes:
	set(new_die_type):
		die_type = new_die_type
		_set_die_type(new_die_type)

func _ready() -> void:
	pass

func _set_die_type(new_die_type: DiceTypes):
	_set_die_texture(new_die_type)
	queue_redraw()

func _set_die_texture(new_die_type: DiceTypes):
	match new_die_type:
		DiceTypes.D4:
			_disable_all_dice_textures()
			$d4.visible = true
		DiceTypes.D6:
			_disable_all_dice_textures()
			$d6.visible = true
		_:
			_disable_all_dice_textures()

func _disable_all_dice_textures():
	for texture in get_children():
		texture.visible = false
