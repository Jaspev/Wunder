extends Node2D

#items
var hp1 = preload("res://scenes/items/ItemHP1.tscn")
var hp2 = preload("res://scenes/items/ItemHP2.tscn")
var hp_items = []

var speed1 = preload("res://scenes/items/ItemPassSpeed1.tscn")
var pass_items = []

var skip_enemy = preload("res://scenes/items/ItemUseSkipEnemy.tscn")
var use_items = []

func _ready():
	randomize()
	#item type positions
	var hp_pos = $PositionHP.position
	var pass_pos = $PositionPass.position #passive
	var use_pos = $PositionUse.position
	
	hp_items = [hp1, hp2]
	pass_items = [speed1]
	use_items = [skip_enemy]
	
	#summon random hp item
	var rand_hp = hp_items[randi() % hp_items.size()]
	var rand_hp_instanced = rand_hp.instance()
	rand_hp_instanced.position = hp_pos
	add_child(rand_hp_instanced)
	
	#summon random passive item
	var rand_pass = pass_items[randi() % pass_items.size()]
	var rand_pass_instanced = rand_pass.instance()
	rand_pass_instanced.position = pass_pos
	add_child(rand_pass_instanced)
	
	#summon random useable item
	var rand_use = use_items[randi() % use_items.size()]
	var rand_use_instanced = rand_use.instance()
	rand_use_instanced.position = use_pos
	add_child(rand_use_instanced)
	
	Global.TimerDeathAnim.connect("timeout", self, "_on_TimerDeathAnim_timeout")

func _on_ShopExit_body_entered(body):
	Global.stopattacktimer()

func _on_TimerDeathAnim_timeout():
	queue_free()
