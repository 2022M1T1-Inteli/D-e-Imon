extends Node2D

var qntVidas = 0 
var FILE_NAME = "user://infos.json"
var randomNumberForDelete = 0
const Perguntas = [
	{'question': 'Quem descobrio o Brasil?', 'an1': 'teste', 'an2': 'teste2', 'an3': 'teste3', 'anc': 1,}, 
	{'question': 'Quem descobrio o Brasilsdasdsa?', 'an1': 'testedasdas', 'an2': 'teste2dasasd', 'an3': 'teste3dasdas', 'anc': 1,}, 
	{'question': 'Quem descobrio o silsdasa?', 'an1': 'tes', 'an2': 'te', 'an3': 'ts', 'anc': 1,}, 
	{'question': 'Quem desc o Brasilsdasdsa?', 'an1': 'tesasdas', 'an2': 'teste2asd', 'an3': 'tee3dasdas', 'anc': 1,},
	{'question': 'Pergunta 5', 'an1': 'Resposta51', 'an2': 'Resposta52', 'an3': 'Resposta53', 'anc': 1,},
	{'question': 'Pergunta 6', 'an1': 'Resposta61', 'an2': 'Resposta62', 'an3': 'Resposta63', 'anc': 1,},
	{'question': 'Pergunta 7', 'an1': 'Resposta71', 'an2': 'Resposta72', 'an3': 'Resposta73', 'anc': 1,},
]

var anc = 1
var liberadoAbrir = false

var justOneTime = Perguntas

func beVisible(visible): 
	$Personagem/Camera/CanvasLayer/Popups/Popup.visible = visible  #Abre o PopUp do quiz

func MensagemPressM(visible):
	$Personagem/Camera/CanvasLayer/Popups/Popup3.visible = visible # Aparece para apertar M.

func messageFinal(text):
	$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = true
																	 #Abre o PopUp de resposta com "Acertou" ou "Errou"
	$Personagem/Camera/CanvasLayer/Popups/Popup2/Label.text = text

func setPopUpContent(question, an1, an2, an3):
	$Personagem/Camera/CanvasLayer/Popups/Popup/Label.text = question
	$Personagem/Camera/CanvasLayer/Popups/Popup/Button2/Label.text = an1
	$Personagem/Camera/CanvasLayer/Popups/Popup/Button3/Label.text = an2    #Passa o conteudo do Quiz para a tela do jogo
	$Personagem/Camera/CanvasLayer/Popups/Popup/Button4/Label.text = an3

func selectQuestion():
	var lenght = float(len(justOneTime)) - 1
#	print(lenght)
	var teste = RandomNumberGenerator.new()
	teste.randomize()
	var randomNumber = teste.randi_range(0, lenght)
#    var randomNumeber = randi()%60+1
	
#    var randomNumber = Math.floor(Math.random() * justOneTime.length)

#	print(randomNumber)

	var selectedQuestion = [justOneTime[randomNumber].question, justOneTime[randomNumber].an1, justOneTime[randomNumber].an2, justOneTime[randomNumber].an3, justOneTime[randomNumber].anc]
#	justOneTime[randomNumber].an1, justOneTime[randomNumber].an2, justOneTime[randomNumber].an3

#	print(selectedQuestion)

#	justOneTime.remove(randomNumber)
	randomNumberForDelete = randomNumber
#	print(justOneTime)

#	if (randomNumber > -1):
#		justOneTime.remove(randomNumber)
#	print(selectedQuestion[0])
	return selectedQuestion

func checkVidas():
	if (qntVidas == 1): #Se tiver somente uma vida
		$Personagem/Camera/Vidas/Vida1.visible = true
		$Personagem/Camera/Vidas/Vida2.visible = false
		$Personagem/Camera/Vidas/Vida3.visible = false
		$Personagem/Camera/Vidas/Vida4.visible = false
		$Personagem/Camera/Vidas/Vida5.visible = false
		$Personagem/Camera/Vidas/VidaVazia.visible = false
	elif (qntVidas == 2): #Se tiver duas vidas
		$Personagem/Camera/Vidas/Vida1.visible = true
		$Personagem/Camera/Vidas/Vida2.visible = true
		$Personagem/Camera/Vidas/Vida3.visible = false
		$Personagem/Camera/Vidas/Vida4.visible = false
		$Personagem/Camera/Vidas/Vida5.visible = false
		$Personagem/Camera/Vidas/VidaVazia.visible = false
	elif (qntVidas == 3): #Se tiver três vidas
		$Personagem/Camera/Vidas/Vida1.visible = true
		$Personagem/Camera/Vidas/Vida2.visible = true
		$Personagem/Camera/Vidas/Vida3.visible = true
		$Personagem/Camera/Vidas/Vida4.visible = false
		$Personagem/Camera/Vidas/Vida5.visible = false
		$Personagem/Camera/Vidas/VidaVazia.visible = false
	elif (qntVidas == 4): #Se tiver quatro vidas
		$Personagem/Camera/Vidas/Vida1.visible = true
		$Personagem/Camera/Vidas/Vida2.visible = true
		$Personagem/Camera/Vidas/Vida3.visible = true
		$Personagem/Camera/Vidas/Vida4.visible = true
		$Personagem/Camera/Vidas/Vida5.visible = false
		$Personagem/Camera/Vidas/VidaVazia.visible = false
	elif (qntVidas == 5): #Se tiver cinco vidas
		$Personagem/Camera/Vidas/Vida1.visible = true
		$Personagem/Camera/Vidas/Vida2.visible = true
		$Personagem/Camera/Vidas/Vida3.visible = true
		$Personagem/Camera/Vidas/Vida4.visible = true
		$Personagem/Camera/Vidas/Vida5.visible = true
		$Personagem/Camera/Vidas/VidaVazia.visible = false
	elif (qntVidas == 0): #Se não tiver nenhuma vida
		$Personagem/Camera/Vidas/Vida1.visible = false
		$Personagem/Camera/Vidas/Vida2.visible = false
		$Personagem/Camera/Vidas/Vida3.visible = false
		$Personagem/Camera/Vidas/Vida4.visible = false
		$Personagem/Camera/Vidas/Vida5.visible = false
		$Personagem/Camera/Vidas/VidaVazia.visible = true
		
var player = {
	'xp': 0,
	'vidas': 0
}

func setPoints(points): #Colca os pontos na HUD do jogo.
	$Personagem/Camera/Pontos.text = str(points) 

func addCoins(qnt):
	var pontosAtual = int($Personagem/Camera/Pontos.text) #Pega os pontos atuais e tranforma em Número
	var pontosAdicionados = pontosAtual ++ qnt #Adiciona o incremento passado pelo parametro da função
	var pontosInString = str(pontosAdicionados) #Retorna a soma para o formato String
	$Personagem/Camera/Pontos.text = pontosInString #Substitui o valor dos pontos pelo valor adicionado
	
func deleteCoins(qnt):
	var pontosAtualRed = int($Personagem/Camera/Pontos.text) #Pega os pontos atuais e tranforma em Número
	var pontosAdicionadosRed = pontosAtualRed - qnt #Retira o incremento passado pelo parametro da função
	var pontosInStringRed = str(pontosAdicionadosRed) #Retorna o total para o formato String
	$Personagem/Camera/Pontos.text = pontosInStringRed #Substitui o valor dos pontos pelo valor retirado
	
func getPoints():
	return int($Personagem/Camera/Pontos.text) #Retorna em forma de número quantos pontos o player possui

func save(): #Salva novas informações no arquivo .JSON
	var file = File.new()
	file.open(FILE_NAME, File.WRITE)
	file.store_string(to_json(player))
	file.close()

func loadInfos(): #Carrega as informações que o arquivo .JSON possui
	var file = File.new()
	if file.file_exists(FILE_NAME):
		file.open(FILE_NAME, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			player = data
		else:
			printerr("Corrupted data!")
	else:
		printerr("No saved data!")

# Called when the node enters the scene tree for the first time.
func _ready():
	loadInfos() #Carrega as infos
	qntVidas = player.vidas #Atualiza a qntDeVidas quando o jogo inicia
	setPoints(player.xp) #Atualiza os pontos quando o jogo inicia
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	checkVidas()
	if liberadoAbrir: #Verifica se o pesonagem está dentro da AREA de Pergunta
		if Input.is_action_pressed('ui_m'):
			beVisible(true) #Torna vísivel o quiz
			get_tree().paused = true
	pass


func _on_Area2D3_body_entered(body):
	if body.name == "Personagem":
		get_tree().change_scene("res://jogoComPixelArt.tscn")
		
	pass # Replace with function body.


func _perguntaEntered(body):
	liberadoAbrir = true #Libera a tecla M para funcionar
	MensagemPressM(true) #Torna o aviso de "Pressione M" visivel
	var content = selectQuestion() #Gera uma pergunta de forma aleatória
	setPopUpContent(content[0],content[1], content[2], content[3]) #Define o conteudo da pergunta
	anc = content[4] #Define qual a resposta correta
	pass


func _perguntaExited(body):
	if body.name == "Personagem": 
		liberadoAbrir = false #Bloqueia a tecla M para funcionar
		MensagemPressM(false) #Torna o aviso de "Pressione M" invisivel
	pass 

func _onFirstOptionSelected():
	if (anc == 1): #Resposta correta
		beVisible(false) #Torna o Quiz invisivel
		get_tree().paused = false
		messageFinal('Acertou') #Define a mensagem de acerto ou erro
		addCoins(100) #Adiciona pontos
		justOneTime.remove(randomNumberForDelete) #Deleto a pergunta que o player acertou
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundo
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false
		liberadoAbrir = false
		player.xp = getPoints() #Captura a quantidade atual de pontos
		save() #Salva no arquivo local
	else: #Resposta errada
		beVisible(false) #Torna o quiz invisivel
		get_tree().paused = false 
		messageFinal('Errou') #Define o conteudo da mensagem final
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundos
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false #Some a mensagem final

func _onSecondOptionSelected():
	if (anc == 2): #Resposta está correta
		beVisible(false) #Torna o quiz invisivel
		get_tree().paused = false #Despausa o jogo
		messageFinal('Acertou') #Define a mensagem que o player receberá
		addCoins(100) #Adiciona os pontos
		justOneTime.remove(randomNumberForDelete) #Deleto a pergunta que o player acertou
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundos
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false
		player.xp = getPoints() #Captura a quantidade atual de pontos
		save() #Salva no arquivo local
	else: #Resposta errada
		beVisible(false) #Torna o quiz invisivel
		get_tree().paused = false #Despausa o jogo
		messageFinal('Errou') #Define a mensagem que o player receberá
		yield(get_tree().create_timer(3.0), "timeout")
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false

func _onThirdOptionSelected():
	if (anc == 3): #Resposta está correta
		beVisible(false) #Torna o quiz invisivel
		get_tree().paused = false
		messageFinal('Acertou') #Define a mensagem final
		addCoins(100) #Adiciona pontos
		justOneTime.remove(randomNumberForDelete) #Deleto a pergunta que o player acertou
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundos
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false #Some a mensagem final
		player.xp = getPoints() #Captura a quantidade atual de pontos
		save() #Salva no arquivo local
	else: #Resposta errada
		beVisible(false) #Torna o quiz invisivel
		get_tree().paused = false
		messageFinal('Errou') #Define a mensagem final
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundos
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false #Some a mensagem final


func _onClosePressed():
	beVisible(false) #Torna tudo referente as perguntas invisível
	get_tree().paused = false #Pausa o jogo
