extends Node2D

func _ready():
	var cover = MeshInstance2D.new()
	cover.mesh = QuadMesh
	cover.scale.x = 7
	cover.scale.y = 7
	yield(get_tree().create_timer(2.5),"timeout")
	add_child(cover)
