extends Node2D

var border = preload("res://scenes/ui/Border.tscn").instance()
var player = preload("res://scenes/Player.tscn").instance()

#enemy vars
var enemy001 = preload("res://scenes/enemies/EnemyG1Flower.tscn")
var enemy002 = preload("res://scenes/enemies/EnemyG1Eye.tscn")
var enemy003 = preload("res://scenes/enemies/EnemyG1003.tscn")
var enemy004 = preload("res://scenes/enemies/EnemyG1004.tscn")
var enemy005 = preload("res://scenes/enemies/EnemyG1005.tscn")
var enemies_g1 = []

var enemy_secret_1 = preload("res://scenes/enemies/EnemySecret001.tscn")
var enemies_secret = []

var boss001 = [preload("res://scenes/bosses/Boss01Lamp.tscn")]
var shop = [preload("res://scenes/Shop.tscn")]

var timeline = []
var timeline_id = 0

var no_hit = 1

var rng = RandomNumberGenerator.new()

var flower_encountered = 0
var lamp_encountered = 0

func _rand_shuffle():
	randomize()
	enemies_g1.shuffle()
#	enemies_g2.shuffle()
	enemies_secret.shuffle()

func _ready():
	enemies_g1 = [enemy001] #[enemy_flower, enemy_eye, enemy_lamp, enemy004, enemy005]
	enemies_secret = [enemy_secret_1]
	_rand_shuffle()
	rng.randomize()
	var secret_enemy_selector = rng.randi_range(1, 100)
	
	timeline += enemies_g1
	if secret_enemy_selector == 1:
		timeline += enemies_secret
	timeline += boss001
	timeline += shop
	
#	add_child(timeline[timeline_id].instance())
	
	#Timer stuff
	Global.TimerAttack.connect("timeout", self, "_on_TimerAttack_timeout")
	Global.TimerDeathAnim.connect("timeout", self, "_on_TimerDeathAnim_timeout")
	Global.TimerPause.connect("timeout", self, "_on_TimerPause_timeout")
	Global.TimerPlayerDeathAnim.connect("timeout", self, "_on_TimerPlayerDeathAnim_timeout")
	Global.TimerPause.start()
	
#	$AudioMusic.play()

	yield(get_tree().create_timer(1),"timeout")
	$QueueFreeDoors.queue_free()

func _physics_process(delta):
	_debug_stuff()
	
	#health ui
	$HeartUI.rect_size.y = Global.health * 64
	#score ui
	$ScoreUI.text = str(Global.score)
	#bottom timer progress bar ui
	$EnemyProgress.value = Global.TimerAttack.time_left
	
	#if enemy attack timer = 0, freeze enemy and projectile groups
	if Global.TimerAttack.time_left == 0:
		get_tree().paused = true
	else:
		get_tree().paused = false
	
	#test if currently no hit during current enemy
	if Global.health != Global.health_start and Global.TimerAttack.time_left > 0:
		no_hit = 0

func _on_TimerAttack_timeout():
	Global.TimerDeathAnim.start()
	
	Global.TimerAttack.wait_time = Global.enemy_time_duration
	
	Global.health_start = Global.health
	
	#nohit bonus (if you no hit normal enemy, +5. If you no hit boss, +15)
	if no_hit == 1 and "Enemy" in str(timeline[timeline_id].instance()):
		Global.score += 5
	if no_hit == 1 and "Boss" in str(timeline[timeline_id].instance()):
		Global.score += 15
	#no matter what, player gets 2 point per enemy/boss clear
	if "Enemy" in str(timeline[timeline_id].instance()) or "Boss" in str(timeline[timeline_id].instance()):
		Global.score += 2
	
	timeline_id += 1
	
	#loop timeline
	if timeline_id == timeline.size():
		timeline_id = 0
	
	#audio
	$AudioDoorClose.play()
	$AudioEnemyDeath.play()

func _on_TimerDeathAnim_timeout():
	Global.TimerPause.start()
	
	#reset everything for next enemy
	get_tree().call_group("Enemy", "queue_free")
	get_tree().call_group("Bullet", "queue_free")

func _on_TimerPause_timeout():
	add_child(timeline[timeline_id].instance()) #summon next thing in timeline
	
	no_hit = 1
	
	Global.current_enemy = timeline[timeline_id].instance()
		
	print("global.current_enemy = ", Global.current_enemy)
	
	if "Boss" in str(timeline[timeline_id].instance()) or "EnemySecret" in str(timeline[timeline_id].instance()):
		Global.TimerAttack.wait_time = Global.boss_time_duration
		$EnemyProgress.max_value = Global.boss_time_duration
	
	if "Enemy" in str(timeline[timeline_id].instance()) or "Shop" in str(timeline[timeline_id].instance()):
		Global.TimerAttack.wait_time = Global.enemy_time_duration
		$EnemyProgress.max_value = Global.enemy_time_duration
	
	Global.TimerAttack.start()
	
	if "Flower" in str(timeline[timeline_id].instance()):
		flower_encountered = 1
		add_child(player)
		add_child(border)
	elif flower_encountered == 1:
		flower_encountered = 2
		player.queue_free()
	
	if "Lamp" in str(timeline[timeline_id].instance()):
		lamp_encountered = 1
		
		border.position.x = 999
		
		$EnemyProgress.margin_left = -365
		$EnemyProgress.margin_top = 128
		$EnemyProgress.margin_right = 365
		$EnemyProgress.margin_bottom = 160
		
		$HeartUI.margin_left = -440
		$HeartUI.margin_top = -112
		$HeartUI.margin_right = -376
		$HeartUI.margin_bottom = 208
		
		$HeartUI.margin_left = -440
		$HeartUI.margin_top = -112
		$HeartUI.margin_right = -376
		$HeartUI.margin_bottom = 208
		
	elif lamp_encountered == 1:
		lamp_encountered = 2
		
		border.position.x = 0
		
		$EnemyProgress.margin_left = -268
		$EnemyProgress.margin_top = 288
		$EnemyProgress.margin_right = 268
		$EnemyProgress.margin_bottom = 320
		
		$HeartUI.margin_left = -344
		$HeartUI.margin_top = -268
		$HeartUI.margin_right = -280
		$HeartUI.margin_bottom = 52
	
func _on_TimerPlayerDeathAnim_timeout():
	get_tree().change_scene("res://scenes/ui/GameOverScreen.tscn")
	get_tree().call_group("Enemy", "queue_free")
	get_tree().call_group("Bullet", "queue_free")

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
	$debuginfo/LHasItem.text = str("has item = ", Global.has_item)
	$debuginfo/LCurrentItemID.text = str("current item id = ", Global.current_item_id)
	$debuginfo/LHPStart.text = str("HP start = ", Global.health_start)
	$debuginfo/LHP.text = str("HP = ", Global.health)
	$debuginfo/LScore.text = str("score = ", Global.score)
	$debuginfo/LTimerAttack.text = str("enemy time left = ", "%.2f" % Global.TimerAttack.time_left)
	$debuginfo/LTimerPlayerDeathAnim.text = str("player death anim time left = ", "%.2f" % Global.TimerPlayerDeathAnim.time_left)
	$debuginfo/LTimerEnemyDeathAnim.text = str("enemy death anim time left = ", "%.2f" % Global.TimerDeathAnim.time_left)
	$debuginfo/LTimerLabelPause.text = str("pause time left = ", "%.2f" % Global.TimerPause.time_left)
	$debuginfo/LNoHit.text = str("currently no hit? = ", no_hit)
	$debuginfo/LTimelineSize.text = str("timeline size = ", timeline.size())
	$debuginfo/LTimelineID.text = str("timelineID = ", timeline_id)
