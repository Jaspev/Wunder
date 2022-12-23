extends Node2D

func _ready():
	$AnimationPlayer.play("Idle")
	Global.TimerAttack.connect("timeout", self, "_on_TimerAttack_timeout")
	Global.TimerDeathAnim.connect("timeout", self, "_on_TimerDeathAnim_timeout")
	
	self.position = Vector2(0, -350)

func _on_TimerAttack_timeout():
	$AnimationPlayer.queue("Death")
	$AnimationPlayer.queue("RESET")
	
func _on_TimerDeathAnim_timeout():
	pass
	#play reset animation but it's not working here ????
