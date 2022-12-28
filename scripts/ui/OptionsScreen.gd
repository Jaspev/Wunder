extends Control

func _ready():
	$AudioStreamPlayer.play()

func _on_ButtonFullscreen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen

func _on_SliderMaster_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	print($GridContainer/SliderMaster.value)

func _on_SliderMusic_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	print($GridContainer/SliderMusic.value)

func _on_SliderSFX_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
	print($GridContainer/SliderSFX.value)

func _on_BackButton_pressed():
	get_tree().change_scene("res://scenes/ui/TitleScreen.tscn")
