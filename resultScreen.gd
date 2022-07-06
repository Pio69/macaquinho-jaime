extends Control

func _ready():
	self.hide()


func _on_Button_button_down():
	self.get_parent().resetGame()
