extends Node2D

onready var warning = $Warning
onready var attack = $Attack
onready var collision = $CollisionShape2D

var wait_time = 1

func _ready():
	yield(get_tree().create_timer(wait_time),"timeout")
	warning.position.x = 9999
	attack.position.x = 0
	collision.position.x = 0
	yield(get_tree().create_timer(wait_time),"timeout")
	queue_free()
