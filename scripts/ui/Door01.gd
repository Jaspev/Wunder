extends Sprite

onready var tween_door01_close = get_node("tween_door01_close")
onready var tween_door01_open = get_node("tween_door01_open")
onready var tween_pos_01 = Vector2(-1184, 0)
onready var tween_pos_02 = Vector2(-704, 0)

func _ready():
	Global.TimerAttack.connect("timeout", self, "_on_TimerAttack_timeout")
	Global.TimerPause.connect("timeout", self, "_on_TimerPause_timeout")

func _on_TimerAttack_timeout():
	tween_door01_close.interpolate_property(self, "position", tween_pos_01, tween_pos_02, 2,  Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	tween_door01_close.start()

func _on_TimerPause_timeout():
	tween_door01_open.interpolate_property(self, "position", tween_pos_02, tween_pos_01, 2,  Tween.TRANS_QUINT, Tween.EASE_OUT)
	tween_door01_open.start()
