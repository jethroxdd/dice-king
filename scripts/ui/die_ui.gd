extends Button
class_name DieUI

var tooltip_data: Array = []  # Данные для показа
var sides: int = 0

@onready
var tooltip_instance = $Tooltip
var mouse_inside: bool:
	get:
		return Methods.is_mouse_over_control(self)
var timer: Timer

func _ready():
	# Создаём таймер (можно через узел)
	timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 0.25
	timer.timeout.connect(_show_tooltip)
	add_child(timer)
	
	# Включаем обработку движения мыши внутри контрола
	mouse_filter = MOUSE_FILTER_STOP

func _process(_delta):
	if not mouse_inside:
		_hide_tooltip()
	#if Methods.is_mouse_over_control(self):
		#if not mouse_inside:
			#_start_timer_with_check()
		#mouse_inside = true
	#else:
		#if mouse_inside:
			#timer.stop()
			#_hide_tooltip()
		#mouse_inside = false
		

func _gui_input(event: InputEvent):
	if event is InputEventMouseMotion and mouse_inside:
		# При любом движении мыши перезапускаем таймер
		_start_timer_with_check()

func _start_timer_with_check():
	timer.stop()
	_hide_tooltip()
	if mouse_inside:
		timer.start()

func set_tooltip_data(data):
	self.tooltip_data = data

func _show_tooltip():
	if not mouse_inside or Global.is_die_tooltip_showed:
		return  # Мышь могла уйти за время таймера
	
	# Создаём тултип, если его нет
	if tooltip_instance:
		# Передаём данные
		if tooltip_instance.has_method("set_data"):
			tooltip_instance.set_data(tooltip_data)
		
		# Позиционируем возле мыши (можно скорректировать)
		tooltip_instance.global_position = get_global_mouse_position() + Vector2(10, 10)
		tooltip_instance.show()
		Global.is_die_tooltip_showed = true

func _hide_tooltip():
	if tooltip_instance:
		tooltip_instance.hide()
		Global.is_die_tooltip_showed = false
