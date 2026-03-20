@tool
class_name ToolForgeDice
extends Node

func change_node_visibility(root_node: Node, new_die_type: ForgeDice.DiceTypes):
	match new_die_type:
		ForgeDice.DiceTypes.D4:
			disable_all_dice_textures(root_node)
			$d4.visible = true
		ForgeDice.DiceTypes.D6:
			disable_all_dice_textures(root_node)
			$d4.visible = true
		_:
			disable_all_dice_textures(root_node)

func disable_all_dice_textures(root_node: Node):
	for texture in root_node.get_children():
		texture.visible = false
