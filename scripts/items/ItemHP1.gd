extends Area2D

var cost = 10

func _on_ItemHP1_body_entered(body):
	if !Global.health == Global.health_cap and Global.score >= cost:
		Global.health += 1
		Global.score -= cost
		queue_free()
