extends Area2D

var cost = 30

func _ready():
	self.connect("body_entered", self, "_on_ItemUseSkipEnemy_body_entered")

func _on_ItemUseSkipEnemy_body_entered(body):
	if Global.score >= cost and Global.has_item == 0:
		Global.has_item = 1
		Global.current_item_id = 1
		Global.score -= cost
		queue_free()
