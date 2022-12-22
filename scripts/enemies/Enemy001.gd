extends Node2D

const bulletpetal_scene = preload("res://scenes/bullets/BulletPetal.tscn")
onready var shoot_timer = $ShootTimer
onready var rotater = $Rotater

# tween vars
onready var tween_move_down = get_node("tween_move_down")
onready var tween_move_up = get_node("tween_move_up")
onready var tween_pos_01 = Vector2(0, -400)
onready var tween_pos_02 = Vector2(0, 400)

const texture_rotate_speed = 200
const rotate_speed = 2000
const shooter_timer_wait_time = 0.25
const spawn_point_count = 6
const radius = 10

func _ready():
	var step = 2 * PI / spawn_point_count
	
	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotater.add_child(spawn_point)
		
	shoot_timer.wait_time = shooter_timer_wait_time
	shoot_timer.start()
	
	$WaitTimer.start()
	
	#start position
	self.position = Vector2(tween_pos_01)
	
	#tween stuff to make enemy move up and down over and over
	yield($WaitTimer, "timeout")
	tween_move_down.interpolate_property(self, "position", tween_pos_01, tween_pos_02, 2,  Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween_move_down.start()

#when tween down completes, start tween up
func _on_tween_move_down_tween_completed(object, key):
	tween_move_up.interpolate_property(self, "position", tween_pos_02, tween_pos_01, 2,  Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween_move_up.start()

#when tween up completes, start tween down
func _on_tween_move_up_tween_completed(object, key):
	tween_move_down.interpolate_property(self, "position", tween_pos_01, tween_pos_02, 2,  Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween_move_down.start()

func _process(delta: float) -> void:
	#bullet spawn object rotation
	var new_rotation = rotater.rotation_degrees + rotate_speed * delta
	rotater.rotation_degrees = fmod(new_rotation, 360)

	#texture rotation
	var textr_rotation = $Sprite.rotation_degrees + texture_rotate_speed * delta
	$Sprite.rotation_degrees = fmod(textr_rotation, 360)
	
func _on_ShootTimer_timeout() -> void:
	#spawn bullets on rotater when ShootTimer timesout
	for s in rotater.get_children():
		var bullet = bulletpetal_scene.instance()
		get_tree().root.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation
