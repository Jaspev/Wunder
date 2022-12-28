extends Control

func _ready():
	$VBoxContainer/ButtonStart.grab_focus()

func _process(delta):
	if $VBoxContainer/ButtonStart.has_focus():
		$Selector.position = $Position2DStart.position
	if $VBoxContainer/ButtonOptions.has_focus():
		$Selector.position = $Position2DOptions.position
	if $VBoxContainer/ButtonQuit.has_focus():
		$Selector.position = $Position2DQuit.position
