extends CharacterBody2D

const SPEED = 200
var bullet_scene = preload("res://Scenes/bullet.tscn")
@onready var shooty_part = $ShootyPart
@onready var shoot_SFX = $ShootSFX
@onready var revive_SFX = $ReviveSFX 
var isReloading = false
var isImmune = false
static var bonusHp = 0
var health = 50 + 10 * bonusHp

func _ready() -> void:
	get_tree().call_group("game", "update_life", health)
	revive_SFX.play()
	
func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())

	velocity.x = Input.get_axis("left", "right") * SPEED
	velocity.y = Input.get_axis("up", "down") * SPEED
	velocity = lerp(get_real_velocity(), velocity, 0.1)
	
	if Input.is_action_just_pressed("shoot"):
		var bullet = bullet_scene.instantiate()
		shoot_SFX.play()
		bullet.global_position = shooty_part.global_position
		bullet.direction = (get_global_mouse_position() - global_position).normalized()
		$/root/Game.add_child(bullet)
	move_and_slide()
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		
		if collision.get_collider().is_in_group("enemies") and not(isReloading) and not(isImmune):
			$"immune time".start()
			isImmune = true
			health -= 10			
			get_tree().call_group("game", "update_life", health)
	if health <= 0:
		bonusHp += 1
		get_tree().reload_current_scene()


func _on_immune_time_timeout() -> void:
	isImmune = false
