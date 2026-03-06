extends Node
## Сигнал установки цели в интерфейсе
@warning_ignore("unused_signal")
signal target_selected()
## Сигнал добавления строчки в логи
@warning_ignore("unused_signal")
signal update_log(text: String)

@warning_ignore("unused_signal")
signal round_start()
@warning_ignore("unused_signal")
signal round_end()

@warning_ignore("unused_signal")
signal die_rolled()
@warning_ignore("unused_signal")
signal focus_used()

@warning_ignore("unused_signal")
signal update_battle_ui()

@warning_ignore("unused_signal")
signal battle_room_entered()
@warning_ignore("unused_signal")
signal battle_room_over(winner: String)
