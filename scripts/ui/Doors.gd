extends Node2D

var tex_bossL = preload("res://textures/doors/doorBossL.png")
var tex_bossR = preload("res://textures/doors/doorBossR.png")
var tex_enemyL = preload("res://textures/doors/doorEnemyL.png")
var tex_enemyR = preload("res://textures/doors/doorEnemyR.png")
var tex_shopL = preload("res://textures/doors/doorShopL.png")
var tex_shopR = preload("res://textures/doors/doorShopR.png")
var tex_titleL = preload("res://textures/doors/doorTitleL.png")
var tex_titleR = preload("res://textures/doors/doorTitleR.png")
var tex_deathL = preload("res://textures/doors/doorDeathL.png")
var tex_deathR = preload("res://textures/doors/doorDeathR.png")

var door_L = Sprite.new()
var door_R = Sprite.new()
var door_tween = Tween.new()

var rdoor_open = Vector2(-480, 0)
var rdoor_closed = Vector2(0, 0)
var ldoor_open = Vector2(480, 0)
var ldoor_closed = Vector2(0, 0)

func _ready():
	door_L.set_texture(tex_titleL)
	door_L.scale.x = 3.2
	door_L.scale.y = 3.2
	door_L.z_index = 999
	door_L.position = Vector2(480, 0)
	add_child(door_L)
	door_R.set_texture(tex_titleR)
	door_R.scale.x = 3.2
	door_R.scale.y = 3.2
	door_R.z_index = 999
	door_R.position = Vector2(-480, 0)
	add_child(door_R)
	add_child(door_tween)
	Global.TimerAttack.connect("timeout", self, "_on_TimerAttack_timeout")
	Global.TimerPause.connect("timeout", self, "_on_TimerPause_timeout")

#on main menu start button press
func _on_ButtonStart_pressed():
	get_tree().paused = true
	_door_close()

func _on_TimerAttack_timeout():
	_door_close()

func _on_TimerPause_timeout():
	door_L.set_texture(tex_enemyL)
	door_R.set_texture(tex_enemyR)
	_door_open()

func _physics_process(_delta):
	if Global.health <= 0:
		door_L.set_texture(tex_deathL)
		door_R.set_texture(tex_deathR)
		_door_close()

func _door_close():
	door_tween.interpolate_property(
		door_L,
		"position",
		ldoor_open,
		ldoor_closed,
		2,
		Tween.TRANS_BOUNCE,
		Tween.EASE_OUT
	)
	door_tween.start()
	door_tween.interpolate_property(
		door_R,
		"position",
		rdoor_open,
		rdoor_closed,
		2,
		Tween.TRANS_BOUNCE,
		Tween.EASE_OUT
	)
	door_tween.start()

func _door_open():
	door_tween.interpolate_property(
		door_L,
		"position",
		ldoor_closed,
		ldoor_open,
		2,
		Tween.TRANS_QUINT,
		Tween.EASE_OUT
	)
	door_tween.start()
	door_tween.interpolate_property(
		door_R,
		"position",
		rdoor_closed,
		rdoor_open,
		2,
		Tween.TRANS_QUINT,
		Tween.EASE_OUT
	)
	door_tween.start()
