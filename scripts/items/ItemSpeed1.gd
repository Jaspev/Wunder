extends Area2D

var cost = 20

func _ready():
	self.connect("body_entered", self, "_on_ItemSpeed1_body_entered")

func _on_ItemSpeed1_body_entered(body):
	if Global.score >= cost:
		Global.move_speed += 2000
		Global.score -= cost
		queue_free()
