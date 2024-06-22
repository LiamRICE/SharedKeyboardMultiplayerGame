extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Ready")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("Process")

func _on_menu_ui_quit_game_button():
	get_tree().quit()

func _on_menu_ui_settings_button():
	pass # Replace with function body.

func _on_menu_ui_start_game_button(target: String):
	get_tree().change_scene_to_file(target)

func _on_menu_ui_online_game_button(target: String):
	print("Going to MP")
	get_tree().change_scene_to_file(target)
