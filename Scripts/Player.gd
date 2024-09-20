extends CharacterBody2D

signal shoot


var zoom = 2 
var screen_size : Vector2
var speed = 200
var can_shoot : bool 
var player_state


func _ready():
	screen_size = get_viewport_rect().size
	reset()
	
	
	
func reset():
	position = screen_size / 2 
	can_shoot = true


func get_input():
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir.normalized() * speed 
	
	#mouse click
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_shoot:
		var dir = get_global_mouse_position() - position
		shoot.emit(position, dir )
		can_shoot = false 
		$ShotTimer.start()

func _physics_process(delta):
	get_input()
	move_and_slide()
	
	
	
	if velocity.length() != 0:
		$AnimatedSprite2D.play()
	else: 
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame = 1
	
	var mouse = get_local_mouse_position()
	var angle = snappedf(mouse.angle(), PI / 4)
	angle = wrapi(int(angle), 0, 4)
	
	$AnimatedSprite2D.animation = "walk" + str(angle)
	
	
	
func player():
	pass
	
	


func _on_shot_timer_timeout() -> void:
	can_shoot = true
