extends Button

func _on_ButtonGameoverQuit_pressed():
	get_tree().paused = false
	Global.resetvars()
	get_tree().change_scene("res://scenes/ui/TitleScreen.tscn")
