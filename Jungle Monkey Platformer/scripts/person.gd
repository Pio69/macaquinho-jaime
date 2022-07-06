extends KinematicBody2D

var velocity = Vector2.ZERO
var moveSpeed = 0
var gravity = 1200
var jumpForce = -680
var isGrounded 
onready var raycasts = $raycasts

var death = false

func _physics_process(delta: float) -> void:
	velocity.y +=  gravity * delta
	var moveDirection = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	
	if Input.is_action_pressed("ui_down"):
		velocity.y = jumpForce*-1 / 2
		
	velocity.x = moveSpeed * moveDirection 
	move_and_slide(velocity)
	
	isGrounded = _check_is_grounded()
	
func _input(event: InputEvent) -> void:
	if event.is_action("ui_up") and isGrounded:
		velocity.y = jumpForce / 2

func _check_is_grounded():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false
	
func _on_VisibilityNotifier2D_screen_exited():
	death = true
