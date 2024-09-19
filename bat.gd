extends CharacterBody2D

@onready var player = get_node("/root/world/Player")

signal hit_player

var alive : bool
var entered : bool 
var speed : int = 100
var direction : Vector2 

func _ready():
	var screen_rect = get_viewport_rect()
	alive = true 
	entered = false 
	#pick a direction for the entrence 
	var dist = screen_rect.get_center() - position 
	#horizontal and verticle checks
	if abs(dist.x) > abs(dist.y):  
		#Horizontal movement
		direction.x = dist.x 
		direction.y = 0
	else:
		#horizontal movement
		direction.x = 0 
		direction.y = dist.y
		
func _physics_process(_delta):
	if alive:
		$AnimatedSprite2D.animation = "Flight"
		if entered:
			direction = (player.position - position)
		direction = direction.normalized()
		velocity = direction * speed
		move_and_slide()
		
	else: 
		pass
		
		
		
		
func die():
	alive = false
	$AnimatedSprite2D.stop()
	#$AnimatedSprite2D.aniamtion = "dead"
	$Area2D/CollisionShape2D.set_deferred("disabled", true)


func _on_entrancetimer_timeout():
	entered = true 


func _on_area_2d_body_entered(_body):
	hit_player.emit()
