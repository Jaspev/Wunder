extends Button

var timer_door_animation_length = Timer.new()

func _ready():
	timer_door_animation_length.one_shot = true
	timer_door_animation_length.wait_time = 2
	timer_door_animation_length.pause_mode = 3
	add_child(timer_door_animation_length)
	timer_door_animation_length.connect("timeout", self, "_on_timer_door_animation_length_timeout")

func _on_ButtonStart_pressed():
	timer_door_animation_length.start()

func _on_timer_door_animation_length_timeout():
	get_tree().change_scene("res://scenes/World.tscn")
