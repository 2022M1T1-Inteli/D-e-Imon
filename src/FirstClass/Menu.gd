extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func goToGame():
		get_tree().change_scene("res://jogoComPixelArt.tscn")
func quitGame(): 
		get_tree().quit()
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func iniciarPressed():
	goToGame()
	pass # Replace with function body.


func sairDoJogo():
	quitGame()
	pass # Replace with function body.
