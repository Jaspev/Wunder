extends Node2D

func _ready():
	$Control/ButtonGameoverRestart.grab_focus()

func _process(delta):
	if $Control/ButtonGameoverRestart.has_focus():
		$Selector.position = Vector2(226, 810)
	
	if $Control/ButtonGameoverQuit.has_focus():
		$Selector.position = Vector2(807, 810)
