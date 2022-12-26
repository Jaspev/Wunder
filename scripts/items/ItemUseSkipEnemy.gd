extends Area2D

var cost = 30

func _ready():
#	print(Global.has_item)
	self.connect("body_entered", self, "_on_ItemUseSkipEnemy_body_entered")

func _on_ItemUseSkipEnemy_body_entered(body):
	if Global.score >= cost and Global.has_item == 0:
		Global.has_item = 1
		Global.score -= cost
		queue_free()
#		print(Global.has_item)

func _physics_process(delta):
	if Input.is_action_just_pressed("use_item"): # and Global.has_item == 1 and !Global.TimerAttack.is_stopped():
		Global.stopattacktimer()
