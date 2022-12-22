extends Node2D

const speed = 250

func _process(delta):
	position += transform.x * speed * delta

func _on_KillTimer_timeout():
	queue_free()
