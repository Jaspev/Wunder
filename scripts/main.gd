extends Node2D

#TESTTESTTESTTETSTESTTESTTESTTESTTESTTEST

#enemy vars
var enemy_flower = preload("res://scenes/enemies/EnemyG1Flower.tscn")
var enemy_eye = preload("res://scenes/enemies/EnemyG1Eye.tscn")
#var enemy003 = preload("res://scenes/enemies/EnemyG1003.tscn")
#var enemy004 = preload("res://scenes/enemies/EnemyG1004.tscn")
#var enemy005 = preload("res://scenes/enemies/EnemyG1005.tscn")
var enemies_g1 = []

var boss001 = [preload("res://scenes/bosses/Boss001.tscn")]
var shop = [preload("res://scenes/Shop.tscn")]

var timeline = []
var timeline_id = 0

var no_hit = 1

#runs on scene load
func _ready():
	enemies_g1 = [enemy_flower] #enemy_eye, enemy003, enemy004, enemy005]
	
	_rand_shuffle_enemy_groups()
	
	timeline += enemies_g1
	timeline += boss001
	timeline += shop
	
	add_child(timeline[timeline_id].instance())
	
	#Timer stuff
	Global.TimerAttack.connect("timeout", self, "_on_TimerAttack_timeout")
	Global.TimerDeathAnim.connect("timeout", self, "_on_TimerDeathAnim_timeout")
	Global.TimerPause.connect("timeout", self, "_on_TimerPause_timeout")
	Global.TimerAttack.start()

#runs every frame
func _physics_process(delta):
	_debug_stuff()
	
	#health ui
	$HeartUI.rect_size.y = Global.health * 64
	#score ui
	$ScoreUI.text = str(Global.score)
	
	#play player death anim then gameover screen
	if Global.health <= 0:
#		$TimerPlayerDeathAnim.start()
#		get_tree().paused = true
#		yield($TimerPlayerDeathAnim, "timeout")
		get_tree().change_scene("res://scenes/ui/GameOverScreen.tscn")
		get_tree().call_group("Enemy", "queue_free")
		get_tree().call_group("Bullet", "queue_free")
	
	#if enemy attack timer = 0, freeze enemy and projectile groups
	if Global.TimerAttack.time_left == 0:
		get_tree().paused = true #pause
	
	#bottom progress bar ui
	$EnemyProgress.value = Global.TimerAttack.time_left
	
	#test if currently no hit during "timer" (current enemy)
	if Global.health != Global.health_start and Global.TimerAttack.time_left > 0:
		no_hit = 0
	
	#score min cap at 0
	if Global.score <= 0:
		Global.score = 0

#randomize and shuffle enemy array groups
func _rand_shuffle_enemy_groups():
	randomize()
	enemies_g1.shuffle()
#	enemies_g2.shuffle()

func _on_TimerAttack_timeout():
	Global.TimerDeathAnim.start()
	
	Global.TimerAttack.wait_time = Global.enemy_time_duration
	
	if enemies_g1.size() == 0:
		Global.health += 5
	
	if no_hit == 1:
		Global.score += 10
	else:
		Global.score += 5
	
	Global.health_start = Global.health
	
	no_hit = 1
	
	#audio
	$AudioDoorClose.play()
	$AudioEnemyDeath.play()

func _on_TimerDeathAnim_timeout():
	Global.TimerPause.start()
	
	#on turn end BEFORE boss, change attack timer to boss_time_duration
	if timeline_id == 4:
		Global.TimerAttack.wait_time = Global.boss_time_duration
		$EnemyProgress.max_value = Global.boss_time_duration
		
	#on turn end DURING boss, change attack timer to enemy_time_duration
	if timeline_id == 5:
		Global.TimerAttack.wait_time = Global.enemy_time_duration
		$EnemyProgress.max_value = Global.enemy_time_duration
	
	#loop timeline
	if timeline_id == timeline.size() - 1:
		timeline_id = -1
	
	get_tree().call_group("Enemy", "queue_free")
	get_tree().call_group("Bullet", "queue_free")
	$Player.position = Vector2(0,0)

func _on_TimerPause_timeout():
	Global.TimerAttack.start()
	
	get_tree().paused = false #unpause
	
	timeline_id += 1
	add_child(timeline[timeline_id].instance()) #summon next thing in timeline

################################################### DEBUG STUFF ###################################################
func _debug_stuff():
	#Cheats
	if Input.is_action_just_pressed("DEBUG_10points"): #P
		Global.score += 10
	if Input.is_action_just_pressed("DEBUG_1hp"): #+
		Global.health += 1
	if Input.is_action_just_pressed("DEBUG_minus1hp"): #-
		Global.health -= 1
	if Input.is_action_just_pressed("DEBUG_skip") and !Global.TimerAttack.is_stopped(): #backspace
		Global.stopattacktimer()
#		Global.TimerAttack.stop()
#		Global.TimerAttack.wait_time = 0.1
#		Global.TimerAttack.start()

	#Labels
	$debuginfo/LFPS.text = str("FPS = ", Engine.get_frames_per_second())
	$debuginfo/LHPStart.text = str("HP start = ", Global.health_start)
	$debuginfo/LHP.text = str("HP = ", Global.health)
	$debuginfo/LScore.text = str("score = ", Global.score)
	$debuginfo/LTimerAttack.text = str("enemy time left = ", "%.2f" % Global.TimerAttack.time_left)
	$debuginfo/LTimerEnemyDeathAnim.text = str("enemy death anim time left = ", "%.2f" % Global.TimerDeathAnim.time_left)
	$debuginfo/LTimerLabelPause.text = str("pause time left = ", "%.2f" % Global.TimerPause.time_left)
	$debuginfo/LNoHit.text = str("currently no hit? = ", no_hit)
	$debuginfo/LTimelineSize.text = str("timeline size = ", timeline.size())
	$debuginfo/LTimelineID.text = str("timelineID = ", timeline_id)
