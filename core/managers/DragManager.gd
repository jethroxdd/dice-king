extends Node

var current_item = null
var current_slot = null
var slots = []

func add_slot(slot):
	slots.append(slot)

func remove_slot(slot):
	slots.erase(slot)

func _on_drag_start(item):
	current_item = item
	current_slot = item.current_slot

func _on_drag_end(item):
	for slot in slots:
		if slot.can_drop_item(current_item):
			slot.add_item(item.duplicate())
			current_slot.remove_item()
			break
