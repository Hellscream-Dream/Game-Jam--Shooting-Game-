extends Node2D

var enemy_scene = preload("res://Scenes/Enemy.tscn")
@onready var player = $Player
var enemyCanSpawn = false

func _on_timer_timeout() -> void:
	if enemyCanSpawn:
		var enemy = enemy_scene.instantiate()
	
		enemy.global_position = player.global_position
	
		while enemy.global_position.distance_squared_to(player.global_position) < 10000:
			enemy.global_position.x = randi_range(0, get_viewport_rect().size.x)
			enemy.global_position.y = randi_range(0, get_viewport_rect().size.y)
	
		add_child(enemy)

func update_score(score : int ) -> void:
	$HUD/ScoreLabel.text = "Takedown: %d"  %score

func update_life(life : int ) -> void:
	$HUD/LifeLabel.text = "Health: %d"  %life

func update_life(life : int ) -> void:
	$HUD/LifeLabel.text = "Health: %d"  %life

func _on_safe_time_timeout() -> void:
	enemyCanSpawn = true

#######################################################################
#Code fait par Anaïs:
func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
