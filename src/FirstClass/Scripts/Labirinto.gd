extends Node2D

var FILE_NAME = 'user://infos.json'
var player = {
	'isMobile': false
}

func loadInfos():
	var file = File.new()
	if file.file_exists(FILE_NAME):
		file.open(FILE_NAME, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			player = data
			return data
		else:
			printerr("Arquivo corrompido")
	else:
		printerr("Sem informações salvas!")


func _estrelaArrived(body):
	if (body.name == 'Personagem'):
		get_tree().change_scene("res://D&IFobia.tscn")


func _process(delta):
	loadInfos()
	
	if (player.isMobile == true):
		$Cima.visible = true
		$Baixo.visible = true
		$Direita.visible = true
		$Esquerda.visible = true
		$fecharTouch.visible = true

func _fecharTouch():
	get_tree().change_scene("res://D&IFobia.tscn")
