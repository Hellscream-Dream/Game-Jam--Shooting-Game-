extends Node2D

var enemy_scene = preload("res://Scenes/Enemy.tscn")
@onready var player = $Player
var enemyCanSpawn = false
static var score = 0

func _ready() -> void:
	$HUD/again_label.text = "Again"
	
func _on_timer_timeout() -> void:
	if enemyCanSpawn:
		var enemy = enemy_scene.instantiate()
	
		enemy.global_position = player.global_position
	
		while enemy.global_position.distance_squared_to(player.global_position) < 10000:
			enemy.global_position.x = randi_range(0, get_viewport_rect().size.x)
			enemy.global_position.y = randi_range(0, get_viewport_rect().size.y)
	
		add_child(enemy)

func update_score() -> void:
	score += 1
	if score >= 80:
		$HUD/ScoreLabel.add_theme_color_override("font_color", Color.RED)
	$HUD/ScoreLabel.text = "Takedown: %d"  %score

func update_life(life : int ) -> void:
	$HUD/LifeLabel.text = "Health: %d"  %life

func _on_safe_time_timeout() -> void:
	enemyCanSpawn = true

func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_again_showing_time_timeout() -> void:
	$HUD/again_label.text = ""  
