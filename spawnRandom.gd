extends Node2D

onready var pos = $position.position
var objects = [
	preload("res://Obstacles/obstacle1.tscn")
]

var time = 0.0
var interval = 2.0
var maxInterval = 2
var minInterval = 3

var random = 0
var maxPercentage = 40
var banana = preload("res://Banana/banana.tscn")

var vel = 100

func _ready():
	pass 

func _physics_process(delta):
	if(self.get_parent().spawnRandom == true):
		time += delta
		if time >= interval:
			time = 0
			interval = rand_range(minInterval,maxInterval)
			
			var aux = randi() % 1
			var aux2 = objects[aux].instance()
			random = int(rand_range(1,101))
			if(random <= maxPercentage):
				var bananaPosition = aux2.get_node("bananaPosition")
				bananaPosition.add_child(banana.instance())
			aux2.vel = vel
			$position.add_child(aux2)
