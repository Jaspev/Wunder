extends Node2D

onready var tween_ldoor_close = $DoorLeft/tween_ldoor_close
onready var tween_ldoor_open = $DoorLeft/tween_ldoor_open
onready var tween_rdoor_close = $DoorRight/tween_rdoor_close
onready var tween_rdoor_open = $DoorRight/tween_rdoor_open
var ldoor_open = Vector2(-1184, 0)
var ldoor_closed = Vector2(-704, 0)
var rdoor_open = Vector2(1184, 0)
var rdoor_closed = Vector2(704, 0)

func _ready():
	Global.TimerAttack.connect("timeout", self, "_on_TimerAttack_timeout")
	Global.TimerPause.connect("timeout", self, "_on_TimerPause_timeout")

#on attack timer timeout, close doors.
func _on_TimerAttack_timeout():
	#left door close tween
	tween_ldoor_close.interpolate_property(
		$DoorLeft,
		"position",
		ldoor_open,
		ldoor_closed,
		2,
		Tween.TRANS_BOUNCE,
		Tween.EASE_OUT
	)
	#right door close tween
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

#on pause timer timeout, open doors.
func _on_TimerPause_timeout():
	#left door open tween
	tween_ldoor_open.interpolate_property(
		$DoorLeft,
		"position",
		rdoor_closed,
		rdoor_open,
		2,
		Tween.TRANS_QUINT,
		Tween.EASE_OUT
	)
	#right door open tween
	tween_rdoor_open.interpolate_property(
		$DoorRight,
		"position",
		ldoor_closed,
		ldoor_open,
		2,
		Tween.TRANS_QUINT,
		Tween.EASE_OUT
	)
	tween_ldoor_open.start()
	tween_rdoor_open.start()
