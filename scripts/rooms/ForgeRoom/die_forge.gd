extends Control

@onready
var description: Label = $Description/NinePatchRect/Label
@onready
var slots = $Runes/ScrollContainer/GridContainer.get_children() as Array[InvSlot]

func _ready() -> void:
	fill_ui_invrntory()
	

func fill_ui_invrntory():
	var player = GameManager.player
	for i in range(player.max_inv):
		var slot = slots[i]
		var rune = player.inventory.get_item(i)
		var item: InvItem = preload("res://scenes/UI/Drag/item.tscn").instantiate()
		item.set_data(rune)
		slot.add_item(item)
