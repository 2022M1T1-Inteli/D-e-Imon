extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var isVisible = true
var anc = 0

func beVisible(visible): 
	$Popups/Popup.visible = visible  #Abre o PopUp do quiz
	
func messageFinal(text):
	$Popups/Popup2.visible = true
										#Abre o PopUp de resposta com "Acertou" ou "Errou"
	$Popups/Popup2/Label.text = text
	
func setPopUpContent(question, an1, an2, an3):
	$Popups/Popup/Label.text = question
	$Popups/Popup/Button2/Label.text = an1
	$Popups/Popup/Button3/Label.text = an2    #Passa o conteudo do Quiz para a tela do jogo
	$Popups/Popup/Button4/Label.text = an3
	
func addCoins(qnt):
	var pontosAtual = int($Pontos.text) #Pega os pontos atuais e tranforma em Número
	var pontosAdicionados = pontosAtual ++ qnt #Adiciona o incremento passado pelo parametro da função
	var pontosInString = str(pontosAdicionados) #Retorna a soma para o formato String
	$Pontos.text = pontosInString #Substitui o valor dos pontos pelo valor adicionado
	
func deleteCoins(qnt):
	var pontosAtualRed = int($Pontos.text) #Pega os pontos atuais e tranforma em Número
	var pontosAdicionadosRed = pontosAtualRed ++ qnt #Retira o incremento passado pelo parametro da função
	var pontosInStringRed = str(pontosAdicionadosRed) #Retorna o total para o formato String
	$Pontos.text = pontosInStringRed #Substitui o valor dos pontos pelo valor retirado

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_m"):
		beVisible(true)
		setPopUpContent('Testeeeeeeeeeee', 'Ideia', 'Teste', 'Louco') #Informa pergunta, resposta 1, resposta 2, resposta 3
		anc = 2 #Informa qual será a resposta correta 1 = A | 2 = B | 3 = C
#	pass


func _on_Button_pressed_close():
	beVisible(false)
	pass 
	
func _on_Button2_pressed():
	if (anc == 1):
		beVisible(false)
		messageFinal('Acertou')
		addCoins(100)
		yield(get_tree().create_timer(3.0), "timeout")
		$Popups/Popup2.visible = false
	else:
		beVisible(false)
		messageFinal('Errou')
		yield(get_tree().create_timer(3.0), "timeout")
		$Popups/Popup2.visible = false
	pass
# Replace with function body.


func _on_Button3_pressed():
	if (anc == 2):
		beVisible(false)
		messageFinal('Acertou')
		addCoins(100)
		yield(get_tree().create_timer(3.0), "timeout")
		$Popups/Popup2.visible = false
	else:
		beVisible(false)
		messageFinal('Errou')
		yield(get_tree().create_timer(3.0), "timeout")
		$Popups/Popup2.visible = false
	pass # Replace with function body.


func _on_Button4_pressed():
	if (anc == 3):
		beVisible(false)
		messageFinal('Acertou')
		addCoins(100)
		yield(get_tree().create_timer(3.0), "timeout")
		$Popups/Popup2.visible = false
	else:
		beVisible(false)
		messageFinal('Errou')
		yield(get_tree().create_timer(3.0), "timeout")
		$Popups/Popup2.visible = false
	pass # Replace with function body.
	

## Fechar o jogo quando o ESC e apertado
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()
