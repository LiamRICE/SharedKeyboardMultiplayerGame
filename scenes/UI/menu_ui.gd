extends CanvasLayer

signal start_game_button(target: String)
signal quit_game_button
signal settings_button
signal online_game_button(target: String)


func _on_play_button_pressed():
	var target: String = "res://scenes/levels/level_one.tscn"
	start_game_button.emit(target)

func _on_settings_button_pressed():
	settings_button.emit()

func _on_quit_button_pressed():
	quit_game_button.emit()

func _on_online_button_pressed():
	var target: String = "res://online_ui.tscn"
	online_game_button.emit(target)
