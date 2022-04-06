extends Node2D

func _estrelaArrived(body):
	if (body.name == 'Personagem'):
		get_tree().change_scene("res://D&IFobia.tscn")
