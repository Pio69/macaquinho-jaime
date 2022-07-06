extends Node2D

var sum
var points
var bananas

var currentPhase

var phase
var pointsCompletePhase1
var pointsCompletePhase2

var main

var pause = false

var spawnRandom = false

func _ready():
	main = self.get_parent()
	sum = self.get_parent().sum
	points = self.get_parent().points
	bananas = self.get_parent().bananas

	currentPhase = self.get_parent().currentPhase

	pointsCompletePhase1 = self.get_parent().pointsCompletePhase1
	pointsCompletePhase2 = self.get_parent().pointsCompletePhase2
	pass 

func _physics_process(delta):
	if(!$Player.death):
		main.points += sum
		$pointsLabel.set_text("Pontos: " + String(int(main.points)))
		$bananaLabel.set_text("Bananas: " + String(int(main.bananas)))
		$phaseLabel.set_text("Fase " + String(int(main.currentPhase)))
	
	if($Player.death):
		$spawnRandom.vel = 0
		$deathText.visible = true
		$Button.visible = true
		
	if(pause == true):
		self.get_tree().paused = true
		
func pause():
	if(self.get_parent().gamePause == true):
		var position = $spawnRandom/position
		for obstacle in position.get_children():
			obstacle.queue_free()
		spawnRandom = false
	
func _on_Button_button_down():
	pause()
	spawnRandom = true
	self.get_parent().resetPhase()
	$spawnRandom.vel = 100
	$Player.position.x = 72
	$Player.position.y = 150
	$deathText.visible = false
	$Button.visible = false
	$Player.death = false
	print($Player.position.x)
	
