extends Control
class_name InvItem

var current_slot = null
var is_dragged = false
var icon_offset= Vector2(0, 0)

signal drag_start
signal drag_end

func _ready():
	drag_start.connect(GameManager.drag_manager._on_drag_start.bind(self))
	drag_end.connect(GameManager.drag_manager._on_drag_end.bind(self))

func _process(_delta):
	if is_dragged:
		$Icon.global_position = get_global_mouse_position() - icon_offset
	$Icon/Border.visible = Methods.is_mouse_over_control($Icon)	

func _on_button_button_down():
	is_dragged = true
	z_index = 100
	icon_offset = get_local_mouse_position()
	drag_start.emit()

func _on_button_button_up():
	is_dragged = false
	z_index = 0
	$Icon.position = Vector2(0, 0)
	drag_end.emit()

func remove():
	queue_free()
