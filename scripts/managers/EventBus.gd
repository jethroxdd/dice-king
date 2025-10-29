extends Node
## Сигнал установки цели в интерфейсе
signal target_selected()
## Сигнал добавления строчки в логи
signal update_log(text: String)

signal round_start()
signal round_end()

signal die_rolled()

signal update_battle_ui()

signal enter_battle_encounter()
