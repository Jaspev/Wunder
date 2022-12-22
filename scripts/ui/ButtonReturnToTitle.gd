extends Control

func _on_ButtonFullscreen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen

func _on_BackButton_pressed():
	get_tree().change_scene("res://scenes/ui/TitleScreen.tscn")
