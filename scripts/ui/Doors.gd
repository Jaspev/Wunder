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

onready var tween_ldoor_close = $DoorLeft/tween_ldoor_close
onready var tween_ldoor_open = $DoorLeft/tween_ldoor_open
onready var tween_rdoor_close = $DoorRight/tween_rdoor_close
onready var tween_rdoor_open = $DoorRight/tween_rdoor_open

var ldoor_open = Vector2(-1185, 0)
var ldoor_closed = Vector2(-704, 0)
var rdoor_open = Vector2(1185, 0)
var rdoor_closed = Vector2(704, 0)

func _ready():
	door_L.set_texture(tex_titleL)
	door_R.set_texture(tex_titleR)
	add_child(door_L)
	add_child(door_R)
	add_child(door_tween)
	Global.TimerAttack.connect("timeout", self, "_on_TimerAttack_timeout")
	Global.TimerPause.connect("timeout", self, "_on_TimerPause_timeout")

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

func _physics_process(delta):
	if Global.health <= 0:
		door_L.set_texture(tex_deathL)
		door_R.set_texture(tex_deathR)
		_door_close()
