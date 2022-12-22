extends Node2D

func _ready():
	self.position = Vector2(0, -350)

func _on_Enemy_child_entered_tree(node):
	$AnimatedSprite.play("default")
