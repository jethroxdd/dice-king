extends Node

func is_mouse_over_control(control: Control) -> bool:
	# Check if control is valid and visible
	if not control or not control.visible or not control.is_inside_tree():
		return false
	
	# Get global mouse position
	var mouse_global = control.get_viewport().get_mouse_position()
	
	# Convert to local coordinates relative to the control
	var mouse_local = control.get_global_transform().affine_inverse() * mouse_global
	
	# Check if local position is within control's rectangle
	return Rect2(Vector2.ZERO, control.size).has_point(mouse_local)
