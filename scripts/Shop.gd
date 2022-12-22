extends Node2D

#items
var hp1 = preload("res://scenes/items/ItemHP1.tscn")
var hp2 = preload("res://scenes/items/ItemHP2.tscn")
var hp_items = []
var speed1 = preload("res://scenes/items/ItemSpeed1.tscn")
var passive_items = []
#insert useable items here
var use_items = []

func _ready():
	hp_items = [hp1, hp2]
	passive_items = [speed1]
	
	randomize()
	var rand_item = hp_items[randi() % hp_items.size()]
	add_child(rand_item.instance())

func _on_ShopExit_body_entered(body):
	Global.stopattacktimer()
	queue_free()
