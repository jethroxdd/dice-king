extends Control

func get_slots():
	return $GridContainer.get_children()

func _on_button_pressed():
	for slot in get_slots():
		if !slot.current_item:
			var item = preload("res://scenes/Drag/item.tscn").instantiate()
			slot.add_item(item)
			break

func _on_button_3_pressed():
	$GridContainer.add_child(preload("res://scenes/Drag/slot.tscn").instantiate())

func _on_button_2_pressed():
	for slot in get_slots():
		slot.queue_free()
		break
