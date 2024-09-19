extends Node2D

@export var stake_scene : PackedScene


func _on_player_shoot(pos, dir):
	var stake = stake_scene.instantiate()
	add_child(stake)
	stake.position = pos
	stake.direction = dir.normalized()
	stake.add_to_group("stakes")
