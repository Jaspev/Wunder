extends Node2D

var cover = Sprite.new()
var texwhite = preload("res://textures/ui/whitepixel.png")

func _ready():
	cover.set_texture(texwhite)
	cover.scale.x = 208
	cover.scale.y = 208
	yield(get_tree().create_timer(2.5),"timeout")
	add_child(cover)
