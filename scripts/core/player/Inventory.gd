class_name Inventory
extends RefCounted

# Массив слотов, каждый может содержать любой элемент или null
var slots: Array

# Конструктор: создаёт инвентарь заданного размера, заполняя все слоты null
func _init(size: int) -> void:
	slots = []
	slots.resize(size)
	for i in size:
		slots[i] = null

# Добавить элемент в первый свободный слот
func add(item) -> bool:
	for i in range(slots.size()):
		if slots[i] == null:
			slots[i] = item
			return true
	push_error("Inventory is full")
	return false

# Добавить элемент в конкретный слот, если он пуст
func add_to_slot(index: int, item) -> bool:
	if index < 0 or index >= slots.size():
		push_error("Index out of range")
		return false
	if slots[index] != null:
		push_error("Slot %d is already occupied" % index)
		return false
	slots[index] = item
	return true

# Получить элемент из слота (с удалением), если слот пуст — вернёт null
func get_item(index: int):
	if index < 0 or index >= slots.size():
		push_error("Index out of range")
		return null
	var item = slots[index]
	slots[index] = null
	return item

# Поменять местами содержимое двух слотов (работает и с null)
func swap(i: int, j: int) -> void:
	if i < 0 or i >= slots.size() or j < 0 or j >= slots.size():
		push_error("Swap indices out of range")
		return
	var temp = slots[i]
	slots[i] = slots[j]
	slots[j] = temp

func remove_first(item) -> bool:
	for i in range(slots.size()):
		if slots[i] == item:
			slots[i] = null
			return true
	push_error("Item not existing")
	return false
