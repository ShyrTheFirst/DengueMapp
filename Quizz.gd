extends CanvasLayer

const QUESTAO = preload("res://questao.tscn")

@onready var pergunta = $Panel/Pergunta
@onready var opcao_1 = $Panel/Opcao1
@onready var opcao_2 = $Panel/Opcao2
@onready var opcao_3 = $Panel/Opcao3
@onready var opcao_4 = $Panel/Opcao4
@onready var tela_final = $Panel/TelaFinal/GridContainer

var questoes : int = 5
var questao_atual : int = 0

var pergunta_resultado : Dictionary = {}
var opcoes : Dictionary = {}

var pontuacao_final : Dictionary = {}

var client = HTTPClient.new()
const url_data = "https://opensheet.elk.sh/1IPJR3-mvDweH9KDkK4rUei-I2ntMm13qVQJhWMDiOGg/Data"
const headers = ["Content-Type: application/x-www-form-urlencoded"]
var http = HTTPRequest.new()

var canStart : bool = false
var canEnd : bool = false

func _ready() -> void :
	canStart = false
	canEnd = false
	pergunta.visible = canStart
	opcao_1.visible = canStart
	opcao_2.visible = canStart
	opcao_3.visible = canStart
	opcao_4.visible = canStart
	extrair_questoes()
	
func extrair_questoes():
	http.request_completed.connect(get_data)
	add_child(http)
	var err = http.request(url_data, headers, HTTPClient.METHOD_GET)
	if err:
		http.queue_free()
	pass

func get_data(_result,_response_code, _headers, _body):
	if !_result:
		var data = JSON.parse_string(_body.get_string_from_utf8())
		var num_pergunta = 0
		
		for conjunto in data:
			var perguntas = conjunto["pergunta"]
			var opcao1 = conjunto["opcao1"]
			var opcao2 = conjunto["opcao2"]
			var opcao3 = conjunto["opcao3"]
			var opcao4 = conjunto["opcao4"]
			var resposta = conjunto["resposta"]
			pergunta_resultado[num_pergunta] = [perguntas, resposta]
			opcoes[perguntas] = [opcao1,opcao2,opcao3,opcao4]
			num_pergunta += 1
	canStart = true
	pass


func _on_opcao_2_pressed():
	if opcoes[pergunta_resultado[questao_atual][0]][1] == pergunta_resultado[questao_atual][1]:
		pontuacao_final[questao_atual+1] = "Correta"
	else:
		pontuacao_final[questao_atual+1] = "Incorreta"
	questao_atual += 1

func _on_opcao_1_pressed():
	if opcoes[pergunta_resultado[questao_atual][0]][0] == pergunta_resultado[questao_atual][1]:
		pontuacao_final[questao_atual+1] = "Correta"
	else:
		pontuacao_final[questao_atual+1] = "Incorreta"
	questao_atual += 1

func _on_opcao_3_pressed():
	if opcoes[pergunta_resultado[questao_atual][0]][2] == pergunta_resultado[questao_atual][1]:
		pontuacao_final[questao_atual+1] = "Correta"
	else:
		pontuacao_final[questao_atual+1] = "Incorreta"
	questao_atual += 1

func _on_opcao_4_pressed():
	if opcoes[pergunta_resultado[questao_atual][0]][3] == pergunta_resultado[questao_atual][1]:
		pontuacao_final[questao_atual+1] = "Correta"
	else:
		pontuacao_final[questao_atual+1] = "Incorreta"
	questao_atual += 1

func _process(delta):
	questoes = len(pergunta_resultado)-1
	
	if questao_atual > questoes:
		canStart = false
		pergunta.visible = false
		opcao_1.visible = false
		opcao_2.visible = false
		opcao_3.visible = false
		opcao_4.visible = false
		### MOSTRAR TELA DE ACERTOS
		for questao in pontuacao_final:
			var criar_resultado = QUESTAO.instantiate()
			criar_resultado.questao_num = questao
			if pontuacao_final[questao] == "Correta":
				criar_resultado.isRight = true
			else:
				criar_resultado.isRight = false
			tela_final.add_child(criar_resultado)
		questao_atual = 0

	if canStart:
		pergunta.visible = true
		opcao_1.visible = true
		opcao_2.visible = true
		opcao_3.visible = true
		opcao_4.visible = true
		pergunta.text = pergunta_resultado[questao_atual][0]
		opcao_1.text = opcoes[pergunta_resultado[questao_atual][0]][0]
		opcao_2.text = opcoes[pergunta_resultado[questao_atual][0]][1]
		opcao_3.text = opcoes[pergunta_resultado[questao_atual][0]][2]
		opcao_4.text = opcoes[pergunta_resultado[questao_atual][0]][3]

func _on_voltar_pressed():
	get_tree().change_scene_to_file("res://test.tscn")


