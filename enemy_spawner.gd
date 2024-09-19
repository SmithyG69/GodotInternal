extends Node2D

@onready var main = get_node("/root/world")

signal hit_p

var bat_scene := preload("res://bat.tscn")
var spawn_points := []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)




func _on_timer_timeout():
	#Enemy created number
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.size() < get_parent().max_enemies:  
	#Random spawn point picker
		var spawn = spawn_points[randi() % spawn_points.size()]
		#enemy spawn
		var bat = bat_scene.instantiate()
		bat.position = spawn.position 
		bat.hit_player.connect(hit)
		main.add_child(bat)
		bat.add_to_group("enemies")
	
func hit():
	hit_p.emit()
