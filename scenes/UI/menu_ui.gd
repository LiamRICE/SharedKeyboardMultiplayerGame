extends CanvasLayer

signal start_game_button(target: String)
signal quit_game_button
signal settings_button
signal online_game_button(target: String)

func _on_play_button_button_down():
	var target: String = "res://scenes/levels/level_one.tscn"
	start_game_button.emit(target)

func _on_online_button_button_down():
	var target: String = "res://online_ui.tscn"
	print("Sending to MP")
	online_game_button.emit(target)

func _on_settings_button_button_down():
	settings_button.emit()

func _on_quit_button_button_down():
	quit_game_button.emit()
