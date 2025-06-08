extends Area2D

class_name Gem

const SPEED: float = 200
signal gem_off_screen

func die() -> void:
	set_process(false)
	queue_free()

func _process(delta: float) -> void:
	position.y += SPEED * delta
	if position.y > get_viewport_rect().end.y :
		gem_off_screen.emit()
		die()

func _on_area_entered(area: Area2D) -> void:
	print("Gem Hits Paddle")
	die()
