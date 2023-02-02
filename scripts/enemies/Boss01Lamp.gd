extends Node2D

var lampplayfieldborder1 = preload("res://scenes/ui/BorderSmall.tscn").instance()
var lampplayfieldborder2 = preload("res://scenes/ui/BorderSmall.tscn").instance()
var lampplayfieldborder3 = preload("res://scenes/ui/BorderSmall.tscn").instance()

var rng = RandomNumberGenerator.new()
var shuffle_tween = Tween.new()

func _ready():
	$AnimationPlayer.play("Idle")
	Global.TimerAttack.connect("timeout", self, "_on_TimerAttack_timeout")
	Global.TimerDeathAnim.connect("timeout", self, "_on_TimerDeathAnim_timeout")
	
	$Sprites.position = Vector2(0, -350)
	$Sprites.scale = Vector2(1.75, 1.75)
	
	lampplayfieldborder1.position.x = -256
	lampplayfieldborder2.position.x = 0
	lampplayfieldborder3.position.x = 256
	add_child(lampplayfieldborder1)
	add_child(lampplayfieldborder2)
	add_child(lampplayfieldborder3)
	
	rng.randomize()
	var selectedborder1 = rng.randi_range(1, 3)
	var selectedborder2 = rng.randi_range(1, 3)
	while selectedborder1 == selectedborder2:
		selectedborder1 = rng.randi_range(1, 3)
	
	var shufflespeed = 0.3
	add_child(shuffle_tween)
	
	#list of all possible selectedborder combinations
	var pos1 = Vector2(-256,0)
	var pos12 = Vector2(-128, -256)
	var posn12 = Vector2(-128, 256)
	var pos2 = Vector2(0,0)
	var pos23 = Vector2(128,-256)
	var posn23 = Vector2(128,256)
	var pos3 = Vector2(256,0)
	var posbot = Vector2(0, -256)
	var postop = Vector2(0, 256)
	
	yield(get_tree().create_timer(5),"timeout")
	
	var passes = 30
	while passes > 0:
		var playerborderpos = Global.player_pos.x
		if selectedborder1 == 1 and selectedborder2 == 2:
			shuffle_tween.interpolate_property(lampplayfieldborder1, "position", pos1, pos12, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos < -125:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, pos12, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
				
			shuffle_tween.interpolate_property(lampplayfieldborder2, "position", pos2, posn12, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos > -125 and playerborderpos < 130:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, posn12, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
			yield(get_tree().create_timer(shufflespeed),"timeout")
			
			shuffle_tween.interpolate_property(lampplayfieldborder1, "position", pos12, pos2, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos < -125:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, pos2, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
				
			shuffle_tween.interpolate_property(lampplayfieldborder2, "position", posn12, pos1, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos > -125 and playerborderpos < 130:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, pos1, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
			yield(get_tree().create_timer(shufflespeed),"timeout")
			
			lampplayfieldborder1.position.x = -256
			lampplayfieldborder2.position.x = 0
			lampplayfieldborder3.position.x = 256
			
		if selectedborder1 == 1 and selectedborder2 == 3:
			shuffle_tween.interpolate_property(lampplayfieldborder1, "position", pos1, postop, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos < -125:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, postop, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
			
			shuffle_tween.interpolate_property(lampplayfieldborder3, "position", pos3, posbot, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos > 130:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, posbot, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
			yield(get_tree().create_timer(shufflespeed),"timeout")
				
			shuffle_tween.interpolate_property(lampplayfieldborder1, "position", postop, pos3, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos < -125:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, pos3, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
				
			shuffle_tween.interpolate_property(lampplayfieldborder3, "position", posbot, pos1, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos > 130:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, pos1, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
			yield(get_tree().create_timer(shufflespeed),"timeout")
			
			lampplayfieldborder1.position.x = -256
			lampplayfieldborder2.position.x = 0
			lampplayfieldborder3.position.x = 256
			
		if selectedborder1 == 2 and selectedborder2 == 1:
			shuffle_tween.interpolate_property(lampplayfieldborder2, "position", pos2, pos12, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos > -125 and playerborderpos < 130:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, pos12, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
			
			shuffle_tween.interpolate_property(lampplayfieldborder1, "position", pos1, posn12, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos < -125:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, posn12, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
			yield(get_tree().create_timer(shufflespeed),"timeout")
			
			shuffle_tween.interpolate_property(lampplayfieldborder2, "position", pos12, pos1, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos > -125 and playerborderpos < 130:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, pos1, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
				
			shuffle_tween.interpolate_property(lampplayfieldborder1, "position", posn12, pos2, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos < -125:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, pos2, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
			yield(get_tree().create_timer(shufflespeed),"timeout")
			
			lampplayfieldborder1.position.x = -256
			lampplayfieldborder2.position.x = 0
			lampplayfieldborder3.position.x = 256
			
		if selectedborder1 == 2 and selectedborder2 == 3:
			shuffle_tween.interpolate_property(lampplayfieldborder2, "position", pos2, pos23, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos > -125 and playerborderpos < 130:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, pos23, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
				
			shuffle_tween.interpolate_property(lampplayfieldborder3, "position", pos3, posn23, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos > 130:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, posn23, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
			yield(get_tree().create_timer(shufflespeed),"timeout")
			
			shuffle_tween.interpolate_property(lampplayfieldborder2, "position", pos23, pos3, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos > -125 and playerborderpos < 130:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, pos3, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
				
			shuffle_tween.interpolate_property(lampplayfieldborder3, "position", posn23, pos2, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos > 130:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, pos2, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
			yield(get_tree().create_timer(shufflespeed),"timeout")
			
			lampplayfieldborder1.position.x = -256
			lampplayfieldborder2.position.x = 0
			lampplayfieldborder3.position.x = 256
			
		if selectedborder1 == 3 and selectedborder2 == 1:
			shuffle_tween.interpolate_property(lampplayfieldborder3, "position", pos3, posbot, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos > 130:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, posbot, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
			
			shuffle_tween.interpolate_property(lampplayfieldborder1, "position", pos1, postop, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos < -125:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, postop, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
			yield(get_tree().create_timer(shufflespeed),"timeout")
			
			shuffle_tween.interpolate_property(lampplayfieldborder3, "position", posbot, pos1, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos > 130:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, pos1, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
			
			shuffle_tween.interpolate_property(lampplayfieldborder1, "position", postop, pos3, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos < -125:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, pos3, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
			yield(get_tree().create_timer(shufflespeed),"timeout")
			
			lampplayfieldborder1.position.x = -256
			lampplayfieldborder2.position.x = 0
			lampplayfieldborder3.position.x = 256
			
		if selectedborder1 == 3 and selectedborder2 == 2:
			shuffle_tween.interpolate_property(lampplayfieldborder3, "position", pos3, pos23, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos > 130:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, pos23, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
			
			shuffle_tween.interpolate_property(lampplayfieldborder2, "position", pos2, posn23, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos > -125 and playerborderpos < 130:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, posn23, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
			yield(get_tree().create_timer(shufflespeed),"timeout")
			
			shuffle_tween.interpolate_property(lampplayfieldborder3, "position", pos23, pos2, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos > 130:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, pos2, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
			
			shuffle_tween.interpolate_property(lampplayfieldborder2, "position", posn23, pos3, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			shuffle_tween.start()
			if playerborderpos > -125 and playerborderpos < 130:
				shuffle_tween.interpolate_property($Player, "position", $Player.position, pos3, shufflespeed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				shuffle_tween.start()
			yield(get_tree().create_timer(shufflespeed),"timeout")
			
			lampplayfieldborder1.position.x = -256
			lampplayfieldborder2.position.x = 0
			lampplayfieldborder3.position.x = 256
			
			
		rng.randomize()
		selectedborder1 = rng.randi_range(1, 3)
		selectedborder2 = rng.randi_range(1, 3)
		while selectedborder1 == selectedborder2:
			selectedborder1 = rng.randi_range(1, 3)
		
		if shufflespeed >= 0.1:
			shufflespeed -= 0.01
		
		passes -= 1
	
func _on_TimerAttack_timeout():
	$AnimationPlayer.queue("Death")
	$AnimationPlayer.queue("RESET")
