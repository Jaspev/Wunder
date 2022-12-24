extends Node

#player vars
var has_item = 0
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
var TimerAttack = Timer.new()
var TimerDeathAnim = Timer.new()
var TimerPause = Timer.new()

func _ready():
	TimerAttack.one_shot = true
	TimerAttack.wait_time = enemy_time_duration
	TimerAttack.pause_mode = 3
	add_child(TimerAttack)
	
	TimerDeathAnim.one_shot = true
	TimerDeathAnim.wait_time = 2
	TimerDeathAnim.pause_mode = 3
	add_child(TimerDeathAnim)
	
	TimerPause.one_shot = true
	TimerPause.wait_time = 1
	TimerPause.pause_mode = 3
	add_child(TimerPause)

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
