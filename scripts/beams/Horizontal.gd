extends Node2D

var texwhite = preload("res://textures/ui/whitepixel.png")
var warning = Sprite.new()
var hit = Sprite.new()
var collision = CollisionShape2D.new()
var collisionbox = RectangleShape2D.new()

var sizex = 1024
var sizey = 60

func _ready():
	warning.set_texture(texwhite)
	warning.scale.x = sizex
	warning.scale.y = sizey
	warning.modulate.r = 1
	warning.modulate.g = 0
	warning.modulate.b = 0
	warning.modulate.a = 0.27
	add_child(warning)
	
	yield(get_tree().create_timer(1),"timeout")
	
	warning.queue_free()
	
	hit.set_texture(texwhite)
	hit.scale.x = sizex
	hit.scale.y = sizey
	add_child(hit)
	
	collisionbox.extents.x = sizex / 2
	collisionbox.extents.y = sizey / 2
	collision.shape = collisionbox
	$hitbox.add_child(collision)

	yield(get_tree().create_timer(1),"timeout")
