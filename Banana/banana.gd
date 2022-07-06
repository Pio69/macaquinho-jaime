extends Area2D

var game
var main

func _ready():
	main = self.get_parent().get_parent().get_parent().get_parent().get_parent().get_parent()
	game = self.get_parent().get_parent().get_parent().get_parent().get_parent()
	pass 

func _on_Area2D_area_entered(area):
	var bananaLabel = game.get_node("bananaLabel")
	main.bananas += 1
	bananaLabel.set_text("Bananas: " + String(int(main.bananas)))
	self.queue_free()


