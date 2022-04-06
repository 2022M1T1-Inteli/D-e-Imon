extends Node2D

var spritePersonagem = preload("res://teste1.png")


func _ready():
	$AnimationPlayer.play("Nova Animação")
	
	$Personagem/Sprite.texture = spritePersonagem
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#
#func _on_AnimationPlayer_animation_finished(anim_name):
#	$Camera2D3.current = true
#	pass # Replace with function body.
