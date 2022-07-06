extends Control

func _ready():
	pass

	


func _on_Button_button_down():
	self.get_parent().get_node("game").spawnRandom = true
	self.get_parent().resetGame()
