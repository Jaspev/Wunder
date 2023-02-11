extends Node2D

var lampplayfieldborder1 = preload("res://scenes/ui/BorderSmall.tscn").instance()
var lampplayfieldborder2 = preload("res://scenes/ui/BorderSmall.tscn").instance()
var lampplayfieldborder3 = preload("res://scenes/ui/BorderSmall.tscn").instance()
var atkvert1 = preload("res://scenes/beams/Vertical.tscn").instance()
var atkvert2 = preload("res://scenes/beams/Vertical.tscn").instance()
var atkvert3 = preload("res://scenes/beams/Vertical.tscn").instance()
var atkvertwarn1 = preload("res://scenes/beams/VerticalWarning.tscn").instance()
var atkvertwarn2 = preload("res://scenes/beams/VerticalWarning.tscn").instance()
var atkvertwarn3 = preload("res://scenes/beams/VerticalWarning.tscn").instance()
var atkhoriz1 = preload("res://scenes/beams/Horizontal.tscn").instance()
var atkhoriz2 = preload("res://scenes/beams/Horizontal.tscn").instance()
var atkhorizwarn1 = preload("res://scenes/beams/HorizontalWarning.tscn").instance()
var atkhorizwarn2 = preload("res://scenes/beams/HorizontalWarning.tscn").instance()

var rng = RandomNumberGenerator.new()
var shuffle_tween = Tween.new()

var rngatkvert1 = [-311, -256, -201]
var rngatkvert2 = [-55, 0, 55]
var rngatkvert3 = [201, 256, 311]
var rngatkhoriz = [-55, 0, 55]

var atkvert1pos
var atkvert2pos
var atkvert3pos
var atkhoriz1pos
var atkhoriz2pos

func _ready():
	$Enemy/AnimationPlayer.play("Idle")
	Global.TimerAttack.connect("timeout", self, "_on_TimerAttack_timeout")
	Global.TimerDeathAnim.connect("timeout", self, "_on_TimerDeathAnim_timeout")
	
	$Enemy.position.y = -340
	$Enemy.scale = Vector2(1.75, 1.75)
	
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
	
	var playerpos = [-256, 0, 256]
	var rand_pos = playerpos[randi() % playerpos.size()]
	$Player.position.x = rand_pos
	
#	yield(get_tree().create_timer(5),"timeout")
	
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
	
	var passes = 30
	while passes > 0:
		var playerborderpos = $Player.position.x
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
	
	# attack 1
	# warning
	yield(get_tree().create_timer(1),"timeout")
	
	atkvertwarn1.position.x = -311
	atkvertwarn2.position.x = -55
	atkvertwarn3.position.x = 201
	add_child(atkvertwarn1)
	add_child(atkvertwarn2)
	add_child(atkvertwarn3)
	
	# hit
	yield(get_tree().create_timer(1),"timeout")
	
	remove_child(atkvertwarn1)
	remove_child(atkvertwarn2)
	remove_child(atkvertwarn3)
	
	atkvert1.position.x = -311
	atkvert2.position.x = -55
	atkvert3.position.x = 201
	add_child(atkvert1)
	add_child(atkvert2)
	add_child(atkvert3)
	
	yield(get_tree().create_timer(1),"timeout")
	
	remove_child(atkvert1)
	remove_child(atkvert2)
	remove_child(atkvert3)
	
	# attack 2
	# warning
	yield(get_tree().create_timer(1),"timeout")
	
	atkvertwarn1.position.x = -201
	atkvertwarn2.position.x = 0
	atkvertwarn3.position.x = 311
	add_child(atkvertwarn1)
	add_child(atkvertwarn2)
	add_child(atkvertwarn3)
	
	# hit
	yield(get_tree().create_timer(1),"timeout")
	
	remove_child(atkvertwarn1)
	remove_child(atkvertwarn2)
	remove_child(atkvertwarn3)
	atkvert1.position.x = -201
	atkvert2.position.x = 0
	atkvert3.position.x = 311
	add_child(atkvert1)
	add_child(atkvert2)
	add_child(atkvert3)
	
	yield(get_tree().create_timer(1),"timeout")
	
	remove_child(atkvert1)
	remove_child(atkvert2)
	remove_child(atkvert3)
	
	# attack 3
	var attacks = 30
	while attacks > 0:
		randomize()
		var randvert1 = rngatkvert1[randi() % rngatkvert1.size()]
		var randvert2 = rngatkvert2[randi() % rngatkvert2.size()]
		var randvert3 = rngatkvert3[randi() % rngatkvert3.size()]
		var randhoriz1 = rngatkhoriz[randi() % rngatkhoriz.size()]
		var randhoriz2 = rngatkhoriz[randi() % rngatkhoriz.size()]
		
		yield(get_tree().create_timer(1),"timeout")
		
		atkvertwarn1.position.x = randvert1
		atkvertwarn2.position.x = randvert2
		atkvertwarn3.position.x = randvert3
		atkhorizwarn1.position.y = randhoriz1
		atkhorizwarn2.position.y = randhoriz2
		atkvert1.position.x = randvert1
		atkvert2.position.x = randvert2
		atkvert3.position.x = randvert3
		atkhoriz1.position.y = randhoriz1
		atkhoriz2.position.y = randhoriz2
		add_child(atkvertwarn1)
		add_child(atkvertwarn2)
		add_child(atkvertwarn3)
		add_child(atkhorizwarn1)
		add_child(atkhorizwarn2)
		
		yield(get_tree().create_timer(1),"timeout")
		
		remove_child(atkvertwarn1)
		remove_child(atkvertwarn2)
		remove_child(atkvertwarn3)
		remove_child(atkhorizwarn1)
		remove_child(atkhorizwarn2)
		add_child(atkvert1)
		add_child(atkvert2)
		add_child(atkvert3)
		add_child(atkhoriz1)
		add_child(atkhoriz2)
		
		yield(get_tree().create_timer(1),"timeout")
		
		remove_child(atkvert1)
		remove_child(atkvert2)
		remove_child(atkvert3)
		remove_child(atkhoriz1)
		remove_child(atkhoriz2)
		
		attacks -= 1

#func _on_TimerAttack_timeout():
#	$Enemy/AnimationPlayer.queue("Death")
#	$Enemy/AnimationPlayer.queue("RESET")
