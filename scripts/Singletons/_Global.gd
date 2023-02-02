extends Node

#player vars
#health vars
var health = 5
var health_cap = 5
var health_start = 5
#movement vars
var move_speed = 10000
var walk_speed_div = 1.75
var score = 0
#reset vars
var reset_hp = 5
var reset_hp_cap = 5
var reset_hp_start = 5
var reset_speed = 10000
var reset_walk_speed_div = 1.75
var reset_score = 0

#timer vars
var enemy_time_duration = 10
var boss_time_duration = 30
var enemy_death_time_duration = 2
var pause_time_duration = 1
var TimerAttack = Timer.new()
var TimerDeathAnim = Timer.new()
var TimerPause = Timer.new()
var TimerPlayerDeathAnim = Timer.new()
var current_item_sprite = Sprite.new()

#item vars @_@
var has_item = 0
var current_item_id = 0
var tex0_null = preload("res://textures/dev/null.png")
var tex1_skip = preload("res://textures/dev/test.png")
var tex2_health1 = preload("res://textures/dev/test.png")
var tex3_health2 = preload("res://textures/dev/test.png")

var current_enemy = 0

var player_pos = Vector2(0,0)

func _ready():
	add_child(current_item_sprite)
	current_item_sprite.position = Vector2(320, 232)
	
	TimerAttack.one_shot = true
	TimerAttack.wait_time = enemy_time_duration
	TimerAttack.pause_mode = 3
	add_child(TimerAttack)
	
	TimerDeathAnim.one_shot = true
	TimerDeathAnim.wait_time = enemy_death_time_duration
	TimerDeathAnim.pause_mode = 3
	add_child(TimerDeathAnim)
	
	TimerPause.one_shot = true
	TimerPause.wait_time = pause_time_duration
	TimerPause.pause_mode = 3
	add_child(TimerPause)
	
	TimerPlayerDeathAnim.one_shot = true
	TimerPlayerDeathAnim.wait_time = 2
	TimerPlayerDeathAnim.pause_mode = 3
	add_child(TimerPlayerDeathAnim)

func _physics_process(delta):
	#score min cap at 0
	if score <= 0:
		score = 0
	
	#if health is over health_cap var, then just = health_cap
	if health >= health_cap:
		health = health_cap
	
	#same above but for health_start
	if health_start >= health_cap:
		health_start = health_cap

func _input(event):
	#Item stuff
	#ITEM ID 1: SKIP ENEMY
	if current_item_id == 1:
		current_item_sprite.set_texture(tex1_skip)
		if Input.is_action_just_pressed("use_item") and !TimerAttack.is_stopped():
			stopattacktimer()
			has_item = 0
			current_item_id = 0
			current_item_sprite = tex0_null
	#ITEM ID 2: +1 HP
	if current_item_id == 2:
		current_item_sprite.set_texture(tex2_health1)
		if Input.is_action_just_pressed("use_item") and !TimerAttack.is_stopped():
			health += 1
			has_item = 0
			current_item_id = 0
			current_item_sprite = tex0_null
	#ITEM ID 2: +2 HP
	if current_item_id == 3:
		current_item_sprite.set_texture(tex3_health2)
		if Input.is_action_just_pressed("use_item") and !TimerAttack.is_stopped():
			health += 2
			has_item = 0
			current_item_id = 0
			current_item_sprite = tex0_null

func stopattacktimer():
	TimerAttack.stop()
	TimerAttack.wait_time = 0.01
	TimerAttack.start()

func resetvars():
	health = reset_hp
	health_cap = reset_hp_cap
	health_start = reset_hp_start
	move_speed = reset_speed
	walk_speed_div = reset_walk_speed_div
	score = reset_score
