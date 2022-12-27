extends Control

func _ready():
	$VBoxContainer/LabelStart/ButtonStart.grab_focus()

func _process(delta):
	if $VBoxContainer/LabelStart/ButtonStart.has_focus():
		$Selector.position = Vector2(600, 94)
	
	if $VBoxContainer/LabelOptions/ButtonOptions.has_focus():
		$Selector.position = Vector2(819, 186)
	
	if $VBoxContainer/LabelQuit/ButtonQuit.has_focus():
		$Selector.position = Vector2(484, 286)
