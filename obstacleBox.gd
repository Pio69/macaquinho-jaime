extends StaticBody2D

var velocity = Vector2()
var vel = 200

func _ready():
	 velocity = Vector2(-1, 0) 
func _physics_process(delta):
	position.x += velocity.x * delta * vel
	
func _on_visibility_screen_exited():
	queue_free()
