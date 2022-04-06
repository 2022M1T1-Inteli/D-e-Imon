extends Node2D

var spaw_position = null

var tempestade = preload("res://TesteTempestade.tscn")

func _ready():
	randomize()
	spaw_position =  $SpawTempestade.get_children()
	
	pass # Replace with function body.

func spaw_tempestade():
	var index = randi() % spaw_position.size()
	var tempes = tempestade.instance()
	
	tempes.global_position = spaw_position[index].global_position
	add_child(tempes)
	
	



func _on_Timer_timeout():
	spaw_tempestade()
	pass # Replace with function body.
