extends Area2D

var cost = 60
var item_id = 3

func _ready():
	self.connect("body_entered", self, "_on_ItemUse003HP2_body_entered")

func _on_ItemUse003HP2_body_entered(body):
	if Global.score >= cost and Global.has_item == 0:
		Global.has_item = 1
		Global.current_item_id = item_id
		Global.score -= cost
		queue_free()
