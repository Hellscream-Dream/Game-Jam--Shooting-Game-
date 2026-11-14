extends Area2D

var direction: Vector2
const SPEED = 10

func _process(delta: float) -> void:
	global_position += direction * SPEED


#func _on_timer_timeout() -> void:
#	queue_free()
