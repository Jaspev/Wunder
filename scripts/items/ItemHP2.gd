extends Area2D

var cost = 20

func _ready():
	self.connect("body_entered", self, "_on_ItemHP2_body_entered")

func _on_ItemHP2_body_entered(body):
	if !Global.health >= Global.health_cap and Global.score >= cost:
		Global.health += 2
		Global.score -= cost
		queue_free()
