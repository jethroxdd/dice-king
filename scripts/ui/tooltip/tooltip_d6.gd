extends Control
class_name TooltipDieD6

var faces: Array[Node]

func _ready():
	faces = $DieSprite.get_children()

func _clear_data():
	for i in range(6):
		var face = faces[i]
		if face.get_children():
			face.get_child(0).queue_free()

func set_data(data: Array):
	_clear_data()
	var sides: int = data[0]
	var tooltip_data: TooltipData = data[1]
	for i in range(sides):
		var face = tooltip_data.faces[i]
		var tooltip_die_face = faces[face.face]
		var face_icon: TooltipDieFace = load("res://scenes/UI/ToolTip/dice/tooltip_die_face.tscn").instantiate()
		tooltip_die_face.add_child(face_icon)
		face_icon.active(face.active)
		face_icon.set_data(face.value, face.icon_path)
