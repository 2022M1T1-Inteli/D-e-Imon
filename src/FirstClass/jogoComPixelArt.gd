extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var isVisible = true
var anc = 0
var levelPassed = false
var liberadoAbrir = false
var liberadoAbrirE = false
var liberadoAbrirG = false
var qntVidas = 0
var pontosToBuy
var destination
var destination2

#var pontosToBuy = $Personagem/Camera/Pontos.Text #Pega os pontos atuais e tranforma em Número

func checkVidas():
	if (qntVidas == 1):
		$Personagem/Camera/Vidas/Vida1.visible = true
		$Personagem/Camera/Vidas/Vida2.visible = false
		$Personagem/Camera/Vidas/Vida3.visible = false
		$Personagem/Camera/Vidas/Vida4.visible = false
		$Personagem/Camera/Vidas/Vida5.visible = false
		$Personagem/Camera/Vidas/VidaVazia.visible = false
	elif (qntVidas == 2):
		$Personagem/Camera/Vidas/Vida1.visible = true
		$Personagem/Camera/Vidas/Vida2.visible = true
		$Personagem/Camera/Vidas/Vida3.visible = false
		$Personagem/Camera/Vidas/Vida4.visible = false
		$Personagem/Camera/Vidas/Vida5.visible = false
		$Personagem/Camera/Vidas/VidaVazia.visible = false
	elif (qntVidas == 3):
		$Personagem/Camera/Vidas/Vida1.visible = true
		$Personagem/Camera/Vidas/Vida2.visible = true
		$Personagem/Camera/Vidas/Vida3.visible = true
		$Personagem/Camera/Vidas/Vida4.visible = false
		$Personagem/Camera/Vidas/Vida5.visible = false
		$Personagem/Camera/Vidas/VidaVazia.visible = false
	elif (qntVidas == 4):
		$Personagem/Camera/Vidas/Vida1.visible = true
		$Personagem/Camera/Vidas/Vida2.visible = true
		$Personagem/Camera/Vidas/Vida3.visible = true
		$Personagem/Camera/Vidas/Vida4.visible = true
		$Personagem/Camera/Vidas/Vida5.visible = false
		$Personagem/Camera/Vidas/VidaVazia.visible = false
	elif (qntVidas == 5):
		$Personagem/Camera/Vidas/Vida1.visible = true
		$Personagem/Camera/Vidas/Vida2.visible = true
		$Personagem/Camera/Vidas/Vida3.visible = true
		$Personagem/Camera/Vidas/Vida4.visible = true
		$Personagem/Camera/Vidas/Vida5.visible = true
		$Personagem/Camera/Vidas/VidaVazia.visible = false
	elif (qntVidas == 0):
		$Personagem/Camera/Vidas/Vida1.visible = false
		$Personagem/Camera/Vidas/Vida2.visible = false
		$Personagem/Camera/Vidas/Vida3.visible = false
		$Personagem/Camera/Vidas/Vida4.visible = false
		$Personagem/Camera/Vidas/Vida5.visible = false
		$Personagem/Camera/Vidas/VidaVazia.visible = true

func beVisible(visible): 
	$Personagem/Camera/CanvasLayer/Popups/Popup.visible = visible  #Abre o PopUp do quiz
	
func beVisibleMarket(visible):
	$Personagem/Camera/CanvasLayer/Popups/Mercado.visible = visible
	
func MensagemPressM(visible):
	$Personagem/Camera/CanvasLayer/Popups/Popup3.visible = visible # Aparece para apertar M.

func MensagemPressE(visible):
	$Personagem/Camera/CanvasLayer/Popups/Popup4.visible = visible # Aparece para apertar M.

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

func messageMarket(message):
	$Personagem/Camera/CanvasLayer/Popups/marketMessage/Label.text = message
	$Personagem/Camera/CanvasLayer/Popups/marketMessage.visible = true
	yield(get_tree().create_timer(3.0), "timeout")
	$Personagem/Camera/CanvasLayer/Popups/marketMessage.visible = false
#
func _ready():
	destination = get_node("Portaldestination").get_global_position()
	destination2 = get_node("Portaldestination2").get_global_position()
	pass
 

func _process(delta):
	checkVidas()
	pontosToBuy = float($Personagem/Camera/Pontos.text)
	if liberadoAbrir:
		if Input.is_action_pressed('ui_m'):
			beVisible(true)
			get_tree().paused = true
	#		if (levelPassed == true):
	#			$Collisions/mecanicaTeste.disabled = true
	#		else:
	#			$Collisions/mecanicaTeste.disabled = false
	elif liberadoAbrirE:
		if Input.is_action_pressed("ui_e"):
			get_tree().change_scene("res://pong.tscn")
	elif liberadoAbrirG:
		if Input.is_action_pressed("ui_g"):
			beVisibleMarket(true)
			get_tree().paused = true
			MensagemPressG(false)
	else:
		pass

func _on_Button_pressed_close():
	beVisible(false)
	get_tree().paused = false
	
func _on_Button2_pressed():
	if (anc == 1):
		beVisible(false)
		get_tree().paused = false
		messageFinal('Acertou')
		addCoins(100)
		yield(get_tree().create_timer(3.0), "timeout")
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false
	else:
		beVisible(false)
		get_tree().paused = false
		messageFinal('Errou')
		yield(get_tree().create_timer(3.0), "timeout")
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false

func _on_Button3_pressed():
	if (anc == 2):
		beVisible(false)
		get_tree().paused = false
		messageFinal('Acertou')
		addCoins(100)
		yield(get_tree().create_timer(3.0), "timeout")
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false
	else:
		beVisible(false)
		get_tree().paused = false
		messageFinal('Errou')
		yield(get_tree().create_timer(3.0), "timeout")
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false

func _on_Button4_pressed():
	if (anc == 3):
		beVisible(false)
		get_tree().paused = false
		messageFinal('Acertou')
		addCoins(100)
		yield(get_tree().create_timer(3.0), "timeout")
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false
	else:
		beVisible(false)
		get_tree().paused = false
		messageFinal('Errou')
		yield(get_tree().create_timer(3.0), "timeout")
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false# Replace with function body.
	

## Fechar o jogo quando o ESC e apertado
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()

func _on_Area2D_body_entered(body):
	if body.name == "Personagem": # Aparece somente com a colisao DO PERSONAGEM
		liberadoAbrir = true
		MensagemPressM(true)
		setPopUpContent('Quando entro na area selecionada', 'Teste2324234234', 'Teste432423423', 'Louco4324234234')
		anc = 2
#		if Input.is_action_pressed("ui_m"):
#			beVisible(true)
#			get_tree().paused = true
	else:
		get_tree().paused = false # Replace with function body


func _on_Area2D_body_exited(body):
	if body.name == "Personagem": # Aparece somente com a colisao DO PERSONAGEM
		liberadoAbrir = false
		MensagemPressM(false)
	pass # Replace with function body.

func _on_Area2D2_body_entered(body):
	if body.name == 'Personagem':
		#get_tree().change_scene("res://pong.tscn")
		liberadoAbrirE = true
		MensagemPressE(true)
	pass # Replace with function body.

func _on_Area2D2_body_exited(body):
	if body.name == 'Personagem':
		liberadoAbrirE = false
		MensagemPressE(false)
	pass # Replace with function body.


func _pergunta2Enter(body):
	if body.name == 'Personagem':
		liberadoAbrir = true
		MensagemPressM(true)
		setPopUpContent('Essa é a pergunta 2', 'Resposta 1', 'Resposta2', 'Resposta3')
		anc = 3
	else:
		get_tree().paused = false
	pass # Replace with function body.


func _exitedPergunta2(body):
	if body.name == 'Personagem':
		liberadoAbrir = false
		MensagemPressM(false)
	pass # Replace with function body.


func _on_Pergunta3_body_entered(body):
	if body.name == 'Personagem':
		liberadoAbrir = true
		MensagemPressM(true)
		setPopUpContent('Quem descobriu o Brasil', 'Pedro Alvares Cabral', 'Frei Henrique de Coimbra', 'Pero vaz de Caminha')
		anc = 1
	pass # Replace with function body.


func _on_Pergunta3_body_exited(body):
	if body.name == 'Personagem':
		liberadoAbrir = false
		MensagemPressM(false)
	pass # Replace with function body.


func marketOpenMessage(body):
	if body.name == 'Personagem':
		liberadoAbrirG = true
		MensagemPressG(true)
	pass # Replace with function body.


func marketExited(body):
	if body.name == 'Personagem':
		liberadoAbrirG = false
		MensagemPressG(false)
	pass # Replace with function body.


func fecharMarket():
	beVisibleMarket(false)
	get_tree().paused = false
	pass # Replace with function body.

func compraVida():
	if(pontosToBuy >= 1000):
		if (qntVidas < 5):
			deleteCoins(1000)
			beVisibleMarket(false)
			get_tree().paused = false
			messageMarket('Item comprado com sucesso')
			qntVidas += 1
		else:
			beVisibleMarket(false)
			get_tree().paused = false
			messageMarket('Você já possui o máximo vidas')
	else:
		beVisibleMarket(false)
		get_tree().paused = false
		messageMarket('Você não possui dinheiro suficiente')
	pass # Replace with function body.


func comprarFase2():
	if(pontosToBuy >= 2000):
		deleteCoins(2000)
		beVisibleMarket(false)
		get_tree().paused = false
		messageMarket('Item comprado com sucesso')
	else:
		beVisibleMarket(false)
		get_tree().paused = false
		messageMarket('Você não possui dinheiro suficiente')
	pass # Replace with function body.


func comprarFase3():
	print(pontosToBuy)
	if (pontosToBuy >= 3000):
		deleteCoins(3000)
		beVisibleMarket(false)
		get_tree().paused = false
		messageMarket('Item comprado com sucesso')
	else:
		beVisibleMarket(false)
		get_tree().paused = false
		messageMarket('Você não possui dinheiro suficiente')
	pass # Replace with function body.


func _on_Area2D3_body_entered(body):
	if body.name == "Personagem":
		body.set_position(destination)


	pass # Replace with function body.


func _on_Area2D4_body_entered(body):
	body.set_position(destination2)
	pass # Replace with function body.
