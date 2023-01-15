extends Node2D

onready var tween_ldoor_close = $DoorLeft/tween_ldoor_close
onready var tween_ldoor_open = $DoorLeft/tween_ldoor_open
onready var tween_rdoor_close = $DoorRight/tween_rdoor_close
onready var tween_rdoor_open = $DoorRight/tween_rdoor_open
var ldoor_open = Vector2(-1185, 0)
var ldoor_closed = Vector2(-704, 0)
var rdoor_open = Vector2(1185, 0)
var rdoor_closed = Vector2(704, 0)

func _door_close():
	tween_ldoor_close.interpolate_property(
		$DoorLeft,
		"position",
		ldoor_open,
		ldoor_closed,
		2,
		Tween.TRANS_BOUNCE,
		Tween.EASE_OUT
	)
	tween_rdoor_close.interpolate_property(
		$DoorRight,
		"position",
		rdoor_open,
		rdoor_closed,
		2,
		Tween.TRANS_BOUNCE,
		Tween.EASE_OUT
	)
	tween_ldoor_close.start()
	tween_rdoor_close.start()

func _door_open():
	tween_ldoor_open.interpolate_property(
		$DoorLeft,
		"position",
		ldoor_closed,
		ldoor_open,
		2,
		Tween.TRANS_QUINT,
		Tween.EASE_OUT
	)
	tween_rdoor_open.interpolate_property(
		$DoorRight,
		"position",
		rdoor_closed,
		rdoor_open,
		2,
		Tween.TRANS_QUINT,
		Tween.EASE_OUT
	)
	tween_ldoor_open.start()
	tween_rdoor_open.start()

func _ready():
	Global.TimerAttack.connect("timeout", self, "_on_TimerAttack_timeout")
	Global.TimerPause.connect("timeout", self, "_on_TimerPause_timeout")

#on main menu start button press
func _on_ButtonStart_pressed():
	get_tree().paused = true
	_door_close()

func _on_TimerAttack_timeout():
	_door_close()

func _on_TimerPause_timeout():
	_door_open()

func _physics_process(delta):
	if Global.health <= 0:
		_door_close()
