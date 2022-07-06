extends Control

var currentPhase
var currentQuestion

func _ready():
	self.hide()
	
func _physics_process(delta):
	if($Node2D/alternative1.pressed == true or $Node2D/alternative2.pressed == true or $Node2D/alternative3.pressed == true or $Node2D/alternative4.pressed == true):
		$answerButton.disabled = false
	else:
		$answerButton.disabled = true
	currentPhase = self.get_parent().currentPhase
	if(self.get_parent().bananas == 0):
		$tipButton.disabled = true
	else:
		$tipButton.disabled = false
	$bananasLabel.text = "Bananas: " + str(self.get_parent().bananas)
		
func _on_alternative1_toggled(button_pressed):
	if(button_pressed):
		$Node2D/alternative2.pressed = false
		$Node2D/alternative3.pressed = false
		$Node2D/alternative4.pressed = false
		
func _on_alternative2_toggled(button_pressed):
	if(button_pressed):
		$Node2D/alternative1.pressed = false
		$Node2D/alternative3.pressed = false
		$Node2D/alternative4.pressed = false
		
func _on_alternative3_toggled(button_pressed):
	if(button_pressed):
		$Node2D/alternative1.pressed = false
		$Node2D/alternative2.pressed = false
		$Node2D/alternative4.pressed = false
		
func _on_alternative4_toggled(button_pressed):
	if(button_pressed):
		$Node2D/alternative1.pressed = false
		$Node2D/alternative2.pressed = false
		$Node2D/alternative3.pressed = false


func _on_answerButton_button_down():
	if($Node2D/alternative1.pressed == true):
		if(currentPhase == 1):
			self.get_parent().questions.easy[currentQuestion].answer = 0
		else:
			self.get_parent().questions.hard[currentQuestion].answer = 0
	elif($Node2D/alternative2.pressed == true):
		if(currentPhase == 1):
			self.get_parent().questions.easy[currentQuestion].answer = 1
		else:
			self.get_parent().questions.hard[currentQuestion].answer = 1
	elif($Node2D/alternative3.pressed == true):
		if(currentPhase == 1):
			self.get_parent().questions.easy[currentQuestion].answer = 2
		else:
			self.get_parent().questions.hard[currentQuestion].answer = 2
	elif($Node2D/alternative4.pressed == true):
		if(currentPhase == 1):
			self.get_parent().questions.easy[currentQuestion].answer = 3
		else:
			self.get_parent().questions.hard[currentQuestion].answer = 3
	self.get_parent().currentQuestion += 1
	$Node2D/alternative1.pressed = false
	$Node2D/alternative2.pressed = false
	$Node2D/alternative3.pressed = false
	$Node2D/alternative4.pressed = false
	$Node2D/alternative1.disabled = false
	$Node2D/alternative2.disabled = false
	$Node2D/alternative3.disabled = false
	$Node2D/alternative4.disabled = false
	

func _on_tipButton_button_down():
	var random = rand_range(0,4)
	if(currentPhase == 1):
		while(int(random) == self.get_parent().questions.easy[currentQuestion].correct):
			random = rand_range(0,4)
	else:
		while(int(random) == self.get_parent().questions.hard[currentQuestion].correct):
			random = rand_range(0,4)
	if(int(random) == 0):
		$Node2D/alternative1.pressed = false
		$Node2D/alternative1.disabled = true
	elif(int(random) == 1):
		$Node2D/alternative2.pressed = false
		$Node2D/alternative2.disabled = true
	elif(int(random) == 2):
		$Node2D/alternative3.pressed = false
		$Node2D/alternative3.disabled = true
	elif(int(random) == 3):
		$Node2D/alternative4.pressed = false
		$Node2D/alternative4.disabled = true
	self.get_parent().bananas -= 1
