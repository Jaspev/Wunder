extends Button

func _on_ButtonGameoverRestart_pressed():
	get_tree().paused = false
	Global.resetvars()
	get_tree().change_scene("res://scenes/World.tscn")
