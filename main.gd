extends Node2D

var questions = {
	"easy":{
		0:{
			"question":"Quem foi a primeira pessoa a viajar no Espaço?",
			"alternatives":{
				0:"Yuri Garin",
				1:"Neil Armstrong",
				2:"Marcos Pontes",
				3:"Buzz Aldrin"
			},
			"correct":1,
			"answer":0
		},
		1:{
			"question":"Qual a montanha mais alta do mundo?",
			"alternatives":{
				0:"Mauna Kea",
				1:"Monte Chimborazo",
				2:"Monte Everest",
				3:"Pico da Neblina"
			},
			"correct":2,
			"answer":0
		},
		2:{
			"question":"Quanto tempo durou o regime do apartheid na África do Sul",
			"alternatives":{
				0:"51 anos",
				1:"37 anos",
				2:"46 anos",
				3:"22 anos"
			},
			"correct":2,
			"answer":0
		},
		3:{
			"question":"Qual o coletivo de gafanhotos?",
			"alternatives":{
				0:"Nuvem",
				1:"Matilha",
				2:"Rebanho",
				3:"Cardume"
			},
			"correct":0,
			"answer":0
		},
		4:{
			"question":"Em qual das opções TODAS as palavras estão escritas corretamente?",
			"alternatives":{
				0:"Pilia, cocalio, famílha",
				1:"Brasília, ampuleta, Itália",
				2:"Pilha, chocalho, família",
				3:"Toalha, famílha, sandálha"
			},
			"correct":2,
			"answer":0
		}
	},
	"hard":{
		0:{
			"question":"Quem foi a única pessoa na história a receber o Prêmio Nobel em áreas científicas diferentes?",
			"alternatives":{
				0:"Albert Einstein",
				1:"Linus Pauling",
				2:"Marie Curie",
				3:"Stephen Hawking"
			},
			"correct":2,
			"answer":0
		},
		1:{
			"question":"Apenas um dos países abaixo fazia parte da URSS - União das Repúblicas Socialistas Soviéticas. Qual deles?",
			"alternatives":{
				0:"Mongólia",
				1:"Afeganistão",
				2:"Turquia",
				3:"Turcomenistão"
			},
			"correct":3,
			"answer":0
		},
		2:{
			"question":"Assinale a alternativa em que o significado do radical esteja errado",
			"alternatives":{
				0:"hidro: água (exemplo: hidráulico) ",
				1:"pisci: peixe (exemplo: piscicultura) ",
				2:"bio: vida (exemplo biologia)",
				3:"antropo: antigo (exemplo: antropologia)"
			},
			"correct":3,
			"answer":0
		},
		3:{
			"question":"Assinale a alternativa em que a forma está destacada e classificada corretamente.",
			"alternatives":{
				0:"IN-venção: prefixo.",
				1:"pode-MOS: desinência número-pessoal.",
				2:"cifrad- A: vogal temática.",
				3:"rapaziad- A: desinência de gênero"
			},
			"correct":1,
			"answer":0
		},
		4:{
			"question":"Quais são, respectivamente, as capitais da Ucrânia, Finlândia e Países Baixos?",
			"alternatives":{
				0:"Kiev, Helsinque e Amsterdã",
				1:"Odessa, Turku e Roterdã",
				2:"Kiev, Manila e Roterdã",
				3:"Carcóvia, Helsinque e Amsterdã"
			},
			"correct":0,
			"answer":0
		}
	}
}

var sum = 0.2
var points = 0
var bananas = 0

var currentPhase = 1

var pointsCompletePhase1 = 200
var pointsCompletePhase2 = 200

var block = false

var currentQuestion = 0

func _ready():
	pass
	
var grade1 = 0
var countCorrects1 = 0
var grade2 = 0
var countCorrects2 = 0
var media = 0

var gameEnd = false

var gamePause = true
	
func _physics_process(delta):
	if(currentPhase == 1):
		if(points >= pointsCompletePhase1):
			if(currentQuestion <= 4):
				gamePause = true
				$game.pause()
				$game.hide()
				$questions.show()
				$questions/questionLabel.text = questions.easy[currentQuestion].question
				$questions/Node2D/alternative1.text = questions.easy[currentQuestion].alternatives[0]
				$questions/Node2D/alternative2.text = questions.easy[currentQuestion].alternatives[1]
				$questions/Node2D/alternative3.text = questions.easy[currentQuestion].alternatives[2]
				$questions/Node2D/alternative4.text = questions.easy[currentQuestion].alternatives[3]
				$questions.currentQuestion = currentQuestion
				$questions.currentPhase = currentPhase
			else:
				$game.show()
				$game.spawnRandom = true
				$questions.hide()
				points = 0
				currentPhase = 2
				$game/spawnRandom.vel = 175
				currentQuestion = 0
				$game/Player.position.x = 72
	else:
		if(points >= pointsCompletePhase2):
			if(currentQuestion <= 4):
				gamePause = true
				$game.pause()
				$game.hide()
				$questions.show()
				$questions/questionLabel.text = questions.hard[currentQuestion].question
				$questions/Node2D/alternative1.text = questions.hard[currentQuestion].alternatives[0]
				$questions/Node2D/alternative2.text = questions.hard[currentQuestion].alternatives[1]
				$questions/Node2D/alternative3.text = questions.hard[currentQuestion].alternatives[2]
				$questions/Node2D/alternative4.text = questions.hard[currentQuestion].alternatives[3]
				$questions.currentQuestion = currentQuestion
				$questions.currentPhase = currentPhase
			else:
				gamePause = true
				$game.pause()
				$game.hide()
				$questions.hide()
				$resultScreen.show()
				gameEnd()
				gameEnd = true
				
func gameEnd():
	if(!gameEnd):
		for level in questions:
			for question in questions[level]:
				if(questions[level][question].answer == questions[level][question].correct):
					if(level == "easy"):
						grade1 += 2
						countCorrects1 += 1
					else:
						grade2 += 2
						countCorrects2 += 1
				else:
					if(level == "easy"):
						grade1 += 0.75
					else:
						grade2 += 0.75
		$resultScreen/correctAnswers1.text = "Você acertou " + str(countCorrects1) + " na 1ª fase\nNota: " + str(grade1)
		$resultScreen/correctAnswers2.text = "Você acertou " + str(countCorrects2) + " na 2ª fase\nNota: " + str(grade2)
		$resultScreen/mediaLabel.text = "Sua média foi: " + str((grade1 + grade2) / 2)
		if((grade1 + grade2) / 2 >= 6):
			$resultScreen/resultLabel.text = "Parabéns você foi aprovado!"
		else:
			$resultScreen/resultLabel.text = "Infelizmente você foi reprovado! Tente novamente :)"
			
func resetGame():
	gameEnd = false 
	$game.show()
	$questions.hide()
	$resultScreen.hide()
	$initial.hide()
	points = 0
	currentPhase = 1
	$game/spawnRandom.vel = 100
	currentQuestion = 0
	bananas = 0
	$game/Player.position.x = 72
	$game/Player.position.y = 150
	
func resetPhase():
	points = 0
