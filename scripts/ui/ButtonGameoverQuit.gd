extends Button

func _on_ButtonGameoverQuit_pressed():
	Global.resetvars()
	get_tree().change_scene("res://scenes/ui/TitleScreen.tscn")
