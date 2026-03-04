extends Control

var MapContainer: HBoxContainer
var MapLevels: Array[Node]:
	get:
		return MapContainer.get_children()

func _ready() -> void:
	MapContainer = $MapBoxPanel/ScrollContainer/MapContainer
	_create_VBox(MapGraph.levels)

func create_map(map: Dictionary):
	for level: Vector2 in map:
		var map_node: MapGraph.MapNode = map[level]
		var map_node_scene: Control = preload("res://scenes/Map/MapNode.tscn").instantiate()
		map_node_scene.set_anchors_preset(Control.PRESET_CENTER)
		MapLevels[level.x].add_child(map_node_scene)

func _create_VBox(amount: int):
	for i in range(amount):
		var VBox = VBoxContainer.new()
		VBox.alignment = BoxContainer.ALIGNMENT_CENTER
		VBox.custom_minimum_size.x = 150
		MapContainer.add_child(VBox)

func _map_node_position(map_node: Vector2) -> Vector2:
	return Vector2(0, 0)
