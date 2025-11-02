extends Node

enum State{
	MAIN_MENU,
	BATTLE_ROOM,
	EVENT_ROOM,
	SHOP_ROOM
}

var state: State = State.MAIN_MENU

func _ready() -> void:
	pass
	
func set_state(new_state: State):
	pass
