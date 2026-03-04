extends Node2D

@onready
var MapUI = $MapUI
var map_generator = MapGraph.new()
var map = map_generator.generate_map()


func _ready() -> void:
	MapUI.create_map(map)
	map_generator.print_map(map)
