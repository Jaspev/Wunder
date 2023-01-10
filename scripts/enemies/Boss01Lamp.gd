extends Node2D

func _ready():
	$AnimationPlayer.play("Idle")
	Global.TimerAttack.connect("timeout", self, "_on_TimerAttack_timeout")
	Global.TimerDeathAnim.connect("timeout", self, "_on_TimerDeathAnim_timeout")
	
	self.position = Vector2(0, -350)
	self.scale = Vector2(1.5, 1.5)
	
func _on_TimerAttack_timeout():
	$AnimationPlayer.queue("Death")
	$AnimationPlayer.queue("RESET")
