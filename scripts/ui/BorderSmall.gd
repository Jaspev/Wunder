extends Node2D

var texwhite = preload("res://textures/ui/whitepixel.png")
var cover = Sprite.new()
var fade_tween = Tween.new()

func _ready():
	cover.set_texture(texwhite)
	cover.scale.x = 208
	cover.scale.y = 208
	cover.modulate.a = 0
#	add_child(cover)
	
	yield(get_tree().create_timer(2.5),"timeout")
	
	fade_tween.interpolate_property(
		cover,
		"modulate:a",
		0,
		1,
		1
	)
	add_child(fade_tween)
	fade_tween.start()
