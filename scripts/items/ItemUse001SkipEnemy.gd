extends Area2D

var cost = 40
var item_id = 1

func _ready():
	self.connect("body_entered", self, "_on_ItemUse01SkipEnemy_body_entered")

func _on_ItemUse01SkipEnemy_body_entered(body):
	if Global.score >= cost and Global.has_item == 0:
		Global.has_item = 1
		Global.current_item_id = item_id
		Global.score -= cost
		queue_free()
