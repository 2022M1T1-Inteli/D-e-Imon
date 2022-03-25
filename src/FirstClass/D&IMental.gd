extends Node2D

var qntVidas = 0 
var FILE_NAME = "user://infos.json"
var FILE_PERGUNTAS = "user://PerguntasFase1.JSON"
var randomNumberForDelete = 0
var timeline = ''
var cenaDestination = "res://D&IMental.tscn"
#Define as perguntas padrões
const Perguntas = [
	{'question': 'Qual o nome dado ao preconceito contra vítimas de transtornos mentais? ', 'an1': 'Psicofobia', 'an2': 'Capacitismo', 'an3': 'Mentalismo', 'anc': 1, "tip": "Esse é um teste de dica, segue-se dessa forma nesse naipaaoooooo, yep bros, i am just writen a long text because I need a lot of space in the page, to test if my apllication test is well, thanks very much for paying attention at my text good lucky for everyone and THANKKSSSS A LOOTTTTT", "feedback": "Teste"},
	{'question': 'Qual a campanha mais famosa de prevenção ao suicídio?', 'an1': 'Dia Mundial da Saúde Mental', 'an2': 'Janeiro Branco', 'an3': 'Setembro Amarelo', 'anc': 3, "tip": "Esse é um teste de dica, segue-se dessa forma nesse naipaaoooooo, yep bros, i am just writen a long text because I need a lot of space in the page, to test if my apllication test is well, thanks very much for paying attention at my text good lucky for everyone and THANKKSSSS A LOOTTTTT", "feedback": "Teste"},
	{'question': 'A psicofobia é enquadrada no código penal como:', 'an1': 'Difamação', 'an2': 'Injúria', 'an3': 'Calúnia', 'anc': 2, "tip": "Esse é um teste de dica, segue-se dessa forma nesse naipaaoooooo, yep bros, i am just writen a long text because I need a lot of space in the page, to test if my apllication test is well, thanks very much for paying attention at my text good lucky for everyone and THANKKSSSS A LOOTTTTT", "feedback": "Teste"},
	{'question': 'Qual o tamanho da pena para quem comete psicofobia?', 'an1': '2 a 4 anos', 'an2': '8 anos', 'an3': 'Apenas multa', 'anc': 1, "tip": "Esse é um teste de dica, segue-se dessa forma nesse naipaaoooooo, yep bros, i am just writen a long text because I need a lot of space in the page, to test if my apllication test is well, thanks very much for paying attention at my text good lucky for everyone and THANKKSSSS A LOOTTTTT", "feedback": "Teste"},
	{'question': 'Em qual hospital ocorreu o "holocausto brasileiro"?', 'an1': 'Hospital de Barbacena', 'an2': 'Hospital Primavera', 'an3': 'Hospital Albert Einstein', 'anc': 1, "tip": "Esse é um teste de dica, segue-se dessa forma nesse naipaaoooooo, yep bros, i am just writen a long text because I need a lot of space in the page, to test if my apllication test is well, thanks very much for paying attention at my text good lucky for everyone and THANKKSSSS A LOOTTTTT", "feedback": "Teste"},
	{'question': 'Quais as principais razões pelas quais os doentes mentais sofriam tanto no Hospital de Barbacena?', 'an1': 'Por conta da sua origem', 'an2': 'Por preconceito racial', 'an3': 'Discriminação em relação a sua adversidade mental', 'anc': 3, "tip": "Esse é um teste de dica, segue-se dessa forma nesse naipaaoooooo, yep bros, i am just writen a long text because I need a lot of space in the page, to test if my apllication test is well, thanks very much for paying attention at my text good lucky for everyone and THANKKSSSS A LOOTTTTT", "feedback": "Teste"},
	{'question': 'Quais os dois transtornos mentais mais comuns no Brasil?', 'an1': 'Depressão e ansiedade', 'an2': 'TDAH e transtorno de personalidade', 'an3': 'Bipolaridade e esquizofrenia', 'anc': 1, "tip": "Esse é um teste de dica, segue-se dessa forma nesse naipaaoooooo, yep bros, i am just writen a long text because I need a lot of space in the page, to test if my apllication test is well, thanks very much for paying attention at my text good lucky for everyone and THANKKSSSS A LOOTTTTT", "feedback": "Teste"},
	{'question': 'O que não fazer quando alguem tem uma crise de ansidade?', 'an1': 'Ajudar a pessoa a controlar a respiração', 'an2': 'Levar a pessoa ao relaxamento, muscular ou outros', 'an3': 'Fazer piada com a situação', 'anc': 3, "tip": "Esse é um teste de dica, segue-se dessa forma nesse naipaaoooooo, yep bros, i am just writen a long text because I need a lot of space in the page, to test if my apllication test is well, thanks very much for paying attention at my text good lucky for everyone and THANKKSSSS A LOOTTTTT", "feedback": "Teste"},
	{'question': 'O que não fazer quando alguém apresenta sintomas de depressão?', 'an1': 'Ouvir com atenção o que a pessoa tem a dizer', 'an2': 'Minimizar o problema, dizendo que vai passar logo', 'an3': 'Recomendar que ela procure ajuda profissional', 'anc': 2, "tip": "Esse é um teste de dica, segue-se dessa forma nesse naipaaoooooo, yep bros, i am just writen a long text because I need a lot of space in the page, to test if my apllication test is well, thanks very much for paying attention at my text good lucky for everyone and THANKKSSSS A LOOTTTTT", "feedback": "Teste"},
]

var perguntasFromDB = []

#Salva as perguntas dentro do Perguntas.JSON
func savePerguntas():
	var file = File.new()
	file.open(FILE_PERGUNTAS, File.WRITE)
	file.store_string(to_json(perguntasFromDB))
	file.close()

#Faz o load das perguntas que estão dentro do Perguntas.JSON
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
		savePerguntas()

var anc = 1 #Resposta correta
var liberadoAbrir = false #Libera a abertura do QUIZ
var liberadoAbrirG = false #Libera a abertura do Minigame

var justOneTime = Perguntas

#Torna o quiz vísivel
func beVisible(visible): 
	$Personagem/Camera/CanvasLayer/Popups/Popup.visible = visible

#Torna o TIP do QUIZ vísivel
func beVisibleTip(visible): 
	$Personagem/Camera/CanvasLayer/Popups/Popup6.visible = visible

#Torna o feedback do QUIZ vísivel
func beVisibleFeedback(visible): 
	$Personagem/Camera/CanvasLayer/Popups/Popup7.visible = visible

#Define o conteúdo da TIP do QUIZ
func setTipContent(content):
	$Personagem/Camera/CanvasLayer/Popups/Popup6/Label.text = content

#Define o conteúdo do Feedback do QUIZ
func setFeedbackContent(content):
	$Personagem/Camera/CanvasLayer/Popups/Popup7/Label.text = content

# Aparece para apertar M.
func MensagemPressM(visible):
	$Personagem/Camera/CanvasLayer/Popups/Popup3.visible = visible

# Aparece para apertar G.
func MensagemPressG(visible):
	$Personagem/Camera/CanvasLayer/Popups/Popup5.visible = visible

#Abre o PopUp de resposta com "Acertou" ou "Errou"
func messageFinal(text):
	$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = true
	$Personagem/Camera/CanvasLayer/Popups/Popup2/Label.text = text

#Passa o conteudo do Quiz para a tela do jogo
func setPopUpContent(question, an1, an2, an3):
	$Personagem/Camera/CanvasLayer/Popups/Popup/Label.text = question
	$Personagem/Camera/CanvasLayer/Popups/Popup/Button2/Label.text = an1
	$Personagem/Camera/CanvasLayer/Popups/Popup/Button3/Label.text = an2   
	$Personagem/Camera/CanvasLayer/Popups/Popup/Button4/Label.text = an3

#Seleciona uma questão aleatória dentro do banco de questões existentes
func selectQuestion():
	var lenght = float(len(perguntasFromDB)) - 1
	var NumberGenerator = RandomNumberGenerator.new()
	NumberGenerator.randomize()                              #Randomiza um número de 0 até o (lenght do array de perguntas)
	var randomNumber = NumberGenerator.randi_range(0, lenght)
	

	#Guarda um array contendo a pergunta selecionada
	var selectedQuestion = [perguntasFromDB[randomNumber].question, perguntasFromDB[randomNumber].an1, perguntasFromDB[randomNumber].an2, perguntasFromDB[randomNumber].an3, perguntasFromDB[randomNumber].anc, perguntasFromDB[randomNumber].tip, perguntasFromDB[randomNumber].feedback]
	randomNumberForDelete = randomNumber #Guarda o número que foi randomizado, para assim quando a pergunta for acertada, essa possa ser deletada


	return selectedQuestion #Return um array completo com a questão

#Verifica quantas vidas o player tem no DB, e reproduz isso na HUD
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
		
# Variaveis que quarda experiencia "Xp" e vidas do jogador
var player = { 
	'xp': 0,
	'vidas': 0
}

#Colca os pontos na HUD do jogo.
func setPoints(points):
	$Personagem/Camera/Pontos.text = str(points) 

# Executa quando o dialogo é finilazado
func unpause(timeline_Teste): #
	get_tree().change_scene(cenaDestination)


#Add uma quantidade específica de pontos do player
func addCoins(qnt): # Uma função que adiciona coinds "Dinheiro" para o personagem como forma de "Xp"
	var pontosAtual = int($Personagem/Camera/Pontos.text) #Pega os pontos atuais e tranforma em Número
	var pontosAdicionados = pontosAtual ++ qnt #Adiciona o incremento passado pelo parametro da função
	var pontosInString = str(pontosAdicionados) #Retorna a soma para o formato String
	$Personagem/Camera/Pontos.text = pontosInString #Substitui o valor dos pontos pelo valor adicionado
	$Personagem/Camera/moneyChange.text = str("+" + str(qnt)) #Define o valor do moneyChange
	$Personagem/Camera/moneyChange.text_color = Color.green #define a cor 
	$Personagem/Camera/moneyChange.visible = true #Torna o popup de moneychange vísivel
	yield(get_tree().create_timer(6.0), "timeout") #Aguarda 3 segundos
	$Personagem/Camera/moneyChange.visible = false #Torna o popup de moneychange invísivel

#Deleta uma quantidade específica de pontos do player
func deleteCoins(qnt):
	var pontosAtualRed = int($Personagem/Camera/Pontos.text) #Pega os pontos atuais e tranforma em Número
	var pontosAdicionadosRed = pontosAtualRed - qnt #Retira o incremento passado pelo parametro da função
	var pontosInStringRed = str(pontosAdicionadosRed) #Retorna o total para o formato String
	$Personagem/Camera/Pontos.text = pontosInStringRed #Substitui o valor dos pontos pelo valor retirado

#Load quantos pontos o player possui atualmente
func getPoints():
	return int($Personagem/Camera/Pontos.text) #Retorna em forma de número quantos pontos o player possui

#Salva novas informações no arquivo .JSON
func save():
	var file = File.new()
	file.open(FILE_NAME, File.WRITE)
	file.store_string(to_json(player))
	file.close()

#Carrega as informações que o arquivo .JSON possui
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
			save()
	else:
		printerr("Sem informações salvas!")
		save()

# Chamada assim que o jogo é iniciado
func _ready():
	loadInfos() #Carrega as infos
	qntVidas = player.vidas #Atualiza a qntDeVidas quando o jogo inicia
	setPoints(player.xp) #Atualiza os pontos quando o jogo inicia
	$Personagem.position = Global.positionForMapa1
	var checkQntPerguntas = loadPerguntas()
	savePerguntas()
	if checkQntPerguntas != null:
		if len(checkQntPerguntas) == 0:
			perguntasFromDB = Perguntas
			savePerguntas()
		else:
			pass
	else:
		savePerguntas()

#Roda em looping
func _process(delta):
	checkVidas()
	#Verifica se o pesonagem está dentro da AREA de Pergunta
	if liberadoAbrir:
		if Input.is_action_pressed('ui_m'):
			beVisibleTip(true) #Torna vísivel o quiz
			get_tree().paused = true
	#Verifica se o personagem está dentro de AREA de minigame
	if liberadoAbrirG:
		if Input.is_action_pressed("ui_g"):
			var dialog = Dialogic.start(timeline)
			add_child(dialog)
			dialog.connect('timeline_end', self, "unpause")
	pass

#Quando o personagem entra no portal
func _on_Area2D3_body_entered(body):
	if body.name == "Personagem":
		get_tree().change_scene("res://jogoComPixelArt.tscn")
		
	pass

#Quando você entra dentro de uma área destinada a pergunta
func _perguntaEntered(body):
	var lenghtArray = float(len(perguntasFromDB))
	if lenghtArray >= 1:
		liberadoAbrir = true #Libera a tecla M para funcionar
		MensagemPressM(true) #Torna o aviso de "Pressione M" visivel
		var content = selectQuestion() #Gera uma pergunta de forma aleatória
		setPopUpContent(content[0],content[1], content[2], content[3]) #Define o conteudo da pergunta
		anc = content[4] #Define qual a resposta correta
		setTipContent(content[5])
		setFeedbackContent(content[6])
	else:
		print('Acabou as perguntas!')
	pass

#Quando você sai dentro de uma área destinada a pergunta
func _perguntaExited(body):
	if body.name == "Personagem": 
		liberadoAbrir = false #Bloqueia a tecla M para funcionar
		MensagemPressM(false) #Torna o aviso de "Pressione M" invisivel
	pass 
	

#Quando o botão A é selecionado no QUIZ
func _onFirstOptionSelected():
	if (anc == 1): #Resposta correta
		beVisible(false) #Torna o Quiz invisivel
		get_tree().paused = false
		messageFinal('Acertou') #Define a mensagem de acerto ou erro
		addCoins(500) #Adiciona pontos
		perguntasFromDB.remove(randomNumberForDelete) #Deleto a pergunta que o player acertou
		savePerguntas() #Salva as perguntas após o remove
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundo
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false
		liberadoAbrir = false
		player.xp = getPoints() #Captura a quantidade atual de pontos
		save() #Salva no arquivo local
	else: #Resposta errada
		beVisible(false) #Torna o quiz invisivel
		liberadoAbrir = false
		get_tree().paused = false 
		messageFinal('Errou') #Define o conteudo da mensagem final
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundos
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false #Some a mensagem final
		beVisibleFeedback(true)

#Quando a opção B é selecionada
func _onSecondOptionSelected():
	if (anc == 2): #Resposta está correta
		beVisible(false) #Torna o quiz invisivel
		get_tree().paused = false #Despausa o jogo
		messageFinal('Acertou') #Define a mensagem que o player receberá
		addCoins(500) #Adiciona os pontos
		perguntasFromDB.remove(randomNumberForDelete) #Deleto a pergunta que o player acertou
		savePerguntas() #Salva as perguntas após o remove
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundos
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false
		liberadoAbrir = false
		player.xp = getPoints() #Captura a quantidade atual de pontos
		save() #Salva no arquivo local
	else: #Resposta errada
		beVisible(false) #Torna o quiz invisivel
		liberadoAbrir = false
		get_tree().paused = false #Despausa o jogo
		messageFinal('Errou') #Define a mensagem que o player receberá
		yield(get_tree().create_timer(3.0), "timeout")
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false
		beVisibleFeedback(true)

#Quando a opção C é selecionada
func _onThirdOptionSelected():
#Resposta está correta:
	if (anc == 3):
		beVisible(false) #Torna o quiz invisivel
		get_tree().paused = false
		messageFinal('Acertou') #Define a mensagem final
		addCoins(500) #Adiciona pontos
		perguntasFromDB.remove(randomNumberForDelete) #Deleto a pergunta que o player acertou
		savePerguntas() #Salva as perguntas após o remove
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundos
		liberadoAbrir = false
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false #Some a mensagem final
		player.xp = getPoints() #Captura a quantidade atual de pontos
		save() #Salva no arquivo local
		#Resposta está errada:
	else:
		beVisible(false) #Torna o quiz invisivel
		liberadoAbrir = false
		get_tree().paused = false
		messageFinal('Errou') #Define a mensagem final
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundos
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false #Some a mensagem final
		beVisibleFeedback(true)

#Quando o botão de fechar no QUIZ for selecionado
func _onClosePressed():
	beVisible(false) #Torna tudo referente as perguntas invisível
	get_tree().paused = false #Pausa o jogo

#Quando entra na área de MINIGAME
func _onMinigame1Entered(body):
	liberadoAbrirG = true
	MensagemPressG(true)
	timeline = 'Teste'
	Global.positionForMapa1 = Vector2(337, 925)
	cenaDestination = "res://pong.tscn"
	pass

#Quando o dialogo referente ao minigame é finalizado
func dialogFinished():
	get_tree().change_scene(cenaDestination)

#Quando você sai da área de minigame
func _onMinigameExited(body):
	liberadoAbrirG = false
	MensagemPressG(false)
	pass

#Quando entra na área do segundo minigame
func _onMinigame2Entered(body):
	liberadoAbrirG = true
	MensagemPressG(true)
	timeline = 'Teste'
	cenaDestination = "res://FlappyBrahma.tscn"
	Global.positionForMapa1 = Vector2(563, 932)
	pass # Replace with function body.

#Quando o botão de seguir é pressionado no TIP do QUIZ
func _onButtonSeguirPressed():
	beVisibleTip(false)
	beVisible(true)
	pass

#Quando a resposta selecionado for incorreta
func _onErrouPressed():
	beVisibleFeedback(false)
	pass
