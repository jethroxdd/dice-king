class_name DragManager
extends RefCounted

var current_item: InvItem = null
var swap_item: InvItem = null
var current_slot: BaseSlot = null
var slots: Array[BaseSlot] = []

func add_slot(slot):
	slots.append(slot)

func remove_slot(slot):
	slots.erase(slot)

func _on_drag_start(item):
	current_item = item
	current_slot = item.current_slot

func _on_drag_end(item):
	for slot: BaseSlot in slots:
		if slot.can_drop_item(current_item):
			if slot.current_item:
				swap_item = slot.current_item.duplicate()
			slot.add_item(item.duplicate())
			current_slot.add_item(swap_item)
			break
	
	current_item = null
	current_slot = null
	swap_item = null
