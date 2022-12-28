extends Control

func _ready():
	$VBoxContainer/LabelStart/ButtonStart.grab_focus()

func _process(delta):
	if $VBoxContainer/LabelStart/ButtonStart.has_focus():
		$Selector.position = $Position2DStart.position
	if $VBoxContainer/LabelOptions/ButtonOptions.has_focus():
		$Selector.position = $Position2DOptions.position
	if $VBoxContainer/LabelQuit/ButtonQuit.has_focus():
		$Selector.position = $Position2DQuit.position
