extends Node2D

var qntVidas = 0 
var FILE_NAME = "user://infos.json"
var FILE_PERGUNTAS = "res://Perguntas/Fase1/Perguntas.json"
var randomNumberForDelete = 0
var timeline = ''
const Perguntas = [
	{'question': 'Qual o nome dado ao preconceito contra vítimas de transtornos mentais? ', 'an1': 'Psicofobia', 'an2': 'Capacitismo', 'an3': 'Mentalismo', 'anc': 1,},
	{'question': 'Qual a campanha mais famosa de prevenção ao suicídio?', 'an1': 'Dia Mundial da Saúde Mental', 'an2': 'Janeiro Branco', 'an3': 'Setembro Amarelo', 'anc': 3,},
	{'question': 'Qual a difença entre um psiquiatra e um psicólogo?', 'an1': 'O psicólogo costuma olhar para os problemas psicológicos pela perspectiva filosófica, social e comportamental, já o psiquiatra traz uma visão médica do problema.', 'an2': 'O psicólogo faz faculdade de medicina e o psiquiatra não.', 'an3': 'O psicólogo pode recomendar remédios, diferente do psiquiatra.', 'anc': 1,},
	{'question': 'A psicofobia é enquadrada no código penal como:', 'an1': 'Difamação', 'an2': 'Injúria', 'an3': 'Calúnia', 'anc': 2,},
	{'question': 'Qual o tamanho da pena para quem comete psicofobia?', 'an1': '2 a 4 anos', 'an2': '8 anos', 'an3': 'Apenas multa', 'anc': 1,},
	{'question': 'Em qual hospital ocorreu o "holocausto brasileiro"?', 'an1': 'Hospital de Barbacena', 'an2': 'Hospital Primavera', 'an3': 'Hospital Albert Einstein', 'anc': 1,},
	{'question': 'Quais as principais razões pelas quais os doentes mentais sofriam tanto no Hospital de Barbacena?', 'an1': 'Por conta da sua origem', 'an2': 'Por preconceito racial', 'an3': 'Discriminação em relação a sua adversidade mental', 'anc': 3,},
	{'question': 'Quais os dois transtornos mentais mais comuns no Brasil?', 'an1': 'Depressão e ansiedade', 'an2': 'TDAH e transtorno de personalidade', 'an3': 'Bipolaridade e esquizofrenia', 'anc': 1,},
	{'question': 'O que não fazer quando alguem tem uma crise de ansidade?', 'an1': 'Ajudar a pessoa a controlar a respiração', 'an2': 'Levar a pessoa ao relaxamento, muscular ou outros', 'an3': 'Fazer piada com a situação', 'anc': 3,},
	{'question': 'O que não fazer quando alguém apresenta sintomas de depressão?', 'an1': 'Ouvir com atenção o que a pessoa tem a dizer', 'an2': 'Minimizar o problema, dizendo que vai passar logo', 'an3': 'Recomendar que ela procure ajuda profissional', 'anc': 2,},
]

var perguntasFromDB = []

func savePerguntas():
	var file = File.new()
	file.open(FILE_PERGUNTAS, File.WRITE)
	file.store_string(to_json(perguntasFromDB))
	file.close()

func loadPerguntas():
	var file = File.new()
	if file.file_exists(FILE_PERGUNTAS):
		file.open(FILE_PERGUNTAS, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		perguntasFromDB = data
		return data
	else:
		printerr("No saved data!")

var anc = 1
var liberadoAbrir = false
var liberadoAbrirG = false

var justOneTime = Perguntas

func beVisible(visible): 
	$Personagem/Camera/CanvasLayer/Popups/Popup.visible = visible  #Abre o PopUp do quiz

func MensagemPressM(visible):
	$Personagem/Camera/CanvasLayer/Popups/Popup3.visible = visible # Aparece para apertar M.

func MensagemPressG(visible):
	$Personagem/Camera/CanvasLayer/Popups/Popup5.visible = visible # Aparece para apertar M.

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
	var lenght = float(len(perguntasFromDB)) - 1
#	print(lenght)
	var NumberGenerator = RandomNumberGenerator.new()
	NumberGenerator.randomize()
	var randomNumber = NumberGenerator.randi_range(0, lenght)
#    var randomNumeber = randi()%60+1
	
#    var randomNumber = Math.floor(Math.random() * justOneTime.length)

#	print(randomNumber)

	var selectedQuestion = [perguntasFromDB[randomNumber].question, perguntasFromDB[randomNumber].an1, perguntasFromDB[randomNumber].an2, perguntasFromDB[randomNumber].an3, perguntasFromDB[randomNumber].anc]
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

func unpause(timeline_Teste):
	get_tree().change_scene("res://pong.tscn")

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
			return data
		else:
			printerr("Corrupted data!")
	else:
		printerr("No saved data!")

# Called when the node enters the scene tree for the first time.
func _ready():
	loadInfos() #Carrega as infos
	qntVidas = player.vidas #Atualiza a qntDeVidas quando o jogo inicia
	setPoints(player.xp) #Atualiza os pontos quando o jogo inicia
#	savePerguntas()
	var checkQntPerguntas = loadPerguntas()
	if len(checkQntPerguntas) == 0:
		perguntasFromDB = Perguntas
		savePerguntas()
	else:
		pass

func _process(delta):
	checkVidas()
	if liberadoAbrir: #Verifica se o pesonagem está dentro da AREA de Pergunta
		if Input.is_action_pressed('ui_m'):
			beVisible(true) #Torna vísivel o quiz
			get_tree().paused = true
	if liberadoAbrirG:
		if Input.is_action_pressed("ui_g"):
			var dialog = Dialogic.start(timeline)
			add_child(dialog)
			dialog.connect('timeline_end', self, "unpause")
	pass


func _on_Area2D3_body_entered(body):
	if body.name == "Personagem":
		get_tree().change_scene("res://jogoComPixelArt.tscn")
		
	pass # Replace with function body.


func _perguntaEntered(body):
	var lenghtArray = float(len(perguntasFromDB))
	if lenghtArray >= 1:
		liberadoAbrir = true #Libera a tecla M para funcionar
		MensagemPressM(true) #Torna o aviso de "Pressione M" visivel
		var content = selectQuestion() #Gera uma pergunta de forma aleatória
		setPopUpContent(content[0],content[1], content[2], content[3]) #Define o conteudo da pergunta
		anc = content[4] #Define qual a resposta correta
	else:
		print('Acabou as perguntas!')
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
		perguntasFromDB.remove(randomNumberForDelete) #Deleto a pergunta que o player acertou
		savePerguntas() #Salva as perguntas após o remove
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
		perguntasFromDB.remove(randomNumberForDelete) #Deleto a pergunta que o player acertou
		savePerguntas() #Salva as perguntas após o remove
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
		perguntasFromDB.remove(randomNumberForDelete) #Deleto a pergunta que o player acertou
		savePerguntas() #Salva as perguntas após o remove
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

func _onMinigame1Entered(body):
	liberadoAbrirG = true
	MensagemPressG(true)
	timeline = 'Teste'
	pass

func dialogFinished():
	get_tree().change_scene("res://pong.tscn")


func _onMinigameExited(body):
	liberadoAbrirG = false
	MensagemPressG(false)
	pass
