extends Button

func _on_ButtonGameoverRestart_pressed():
	Global.resetvars()
	get_tree().change_scene("res://scenes/World.tscn")
