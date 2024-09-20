extends Node2D


var wave : int 
var max_enemies : int 
var lives : int 
# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	$GameOver/Button.pressed.connect(new_game)
	
	
func new_game():
	wave = 3
	lives = 3
	max_enemies = 10
	$Player.reset()
	get_tree().call_group("enemies", "queue_free")
	get_tree().call_group("stake", "queue_free")
	get_tree().call_group("items", "queue_free")
	$Hud/LivesLabel.text = "X " + str(lives)
	$Hud/WaveLabel.text = "WAVE: " + str(wave)
	$Hud/EnemiesLabel.text = "X " + str(max_enemies)
	$GameOver.hide()
	$GameOver/Button.pressed.connect(new_game)
	get_tree().paused = true
	$RestartTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_enemy_spawner_hit_p():
	lives -= 1
	$Hud/LivesLabel.text = "X " + str(lives)
	if lives <= 0:
		get_tree().paused = true
		$GameOver/WavesSurvivedLabel.text = "WAVES SURVIVED: " + str(wave - 1)
		$GameOver.show()
	


func _on_restart_timer_timeout() -> void:
	get_tree().paused = false 
