extends Node
## Сигнал установки цели в интерфейсе
signal target_selected()
## Сигнал добавления строчки в логи
signal update_log(text: String)

signal round_start()
signal round_end()

signal die_rolled()
signal focus_used()

signal update_battle_ui()

signal battle_room_entered()
signal battle_room_over(winner: String)
