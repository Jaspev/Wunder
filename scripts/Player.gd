extends KinematicBody2D

func _physics_process(delta):
	#movement
	var move_vec = Vector2()
	if Input.is_action_pressed("move_up"):
		move_vec.y -= 1
	if Input.is_action_pressed("move_down"):
		move_vec.y += 1
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1
	if Input.is_action_pressed("move_right"):
		move_vec.x += 1
	
	#walk movement
	if Input.is_action_pressed("walk"):
		move_and_slide(move_vec * ( Global.move_speed / Global.walk_speed_div ) * delta)
	else:
		move_and_slide(move_vec * Global.move_speed * delta)
	
	#if health is over health_cap var, then just = health_cap
	if Global.health >= Global.health_cap:
		Global.health = Global.health_cap
		
	#same above but for health_start
	if Global.health_start >= Global.health_cap:
		Global.health_start = Global.health_cap
	
func _on_Area2D_area_entered(area):
	if area.is_in_group("Bullet") and $iframes.is_stopped():
		Global.health -= 1
		$iframes.start()
		$animation_damage.queue("flash")

func _on_iframes_timeout():
	$animation_damage.play("RESET")
