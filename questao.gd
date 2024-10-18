extends Label

@onready var cor = $Cor

var questao_num : int
var isRight : bool

func _ready():
	text = "Questao" + str(questao_num)
	if isRight:
		cor.modulate = Color.GREEN
	else:
		cor.modulate = Color.RED
