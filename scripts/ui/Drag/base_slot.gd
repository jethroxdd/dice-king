class_name BaseSlot
extends Control

# Общая переменная для типа слота (может использоваться наследниками)
var slot_type

# Текущий предмет в слоте
var current_item = null:
	set(item):
		current_item = item
		if current_item:
			$ItemContainer.add_child(item)
			current_item.current_slot = self

func _ready() -> void:
	# Регистрируем слот в менеджере перетаскивания
	GameManager.drag_manager.add_slot(self)

func _exit_tree() -> void:
	# Удаляем слот из менеджера при уничтожении
	GameManager.drag_manager.remove_slot(self)

# Добавить предмет в слот (удаляет текущий, если есть)
func add_item(item) -> void:
	if current_item:
		remove_item()
	current_item = item

# Удалить текущий предмет из слота
func remove_item() -> void:
	if current_item:
		current_item.queue_free()
	current_item = null

# Проверка, можно ли бросить предмет в этот слот (по умолчанию – при наведении мыши)
@warning_ignore("unused_parameter")
func can_drop_item(item) -> bool:
	var hover = Methods.is_mouse_over_control(self)
	return hover
