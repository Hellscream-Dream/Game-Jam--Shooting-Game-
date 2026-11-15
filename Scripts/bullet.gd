extends CharacterBody2D

var direction: Vector2
const SPEED = 10
static var takeDown = 0
@onready var explosion = $Boum

func _process(delta: float) -> void:
	global_position += direction * SPEED


func _on_timer_timeout() -> void:
	queue_free()


func _physics_process(delta: float) -> void:
	velocity = direction.normalized() * SPEED
	var collision = move_and_collide(velocity * delta) 
	
	if collision == null:
		return
	var body = collision.get_collider()
	if body.is_in_group("enemies"):
		takeDown += 1
		print("Take down:", takeDown)
		get_tree().call_group("game", "update_score", takeDown)
		explosion.restart()
		explosion.reparent(get_tree().current_scene, true)
		body.queue_free()
		queue_free()
		return
	if body.is_in_group("walls"):
		direction = direction.bounce(collision.get_normal())


	
	
