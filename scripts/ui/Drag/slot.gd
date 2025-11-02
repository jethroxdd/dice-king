extends Control
class_name InvSlot

var current_item = null

func _ready():
	GameManager.drag_manager.add_slot(self)

func _exit_tree():
	GameManager.drag_manager.remove_slot(self)

func add_item(item):
	$ItemContainer.add_child(item)
	current_item = item
	current_item.current_slot = self

func remove_item():
	current_item.queue_free()
	current_item = null

func can_drop_item(item):
	var hover = Methods.is_mouse_over_control(self)
	return hover && current_item == null
