extends Area2D

class_name Paddle

const SPEED: float = 300

func _process(delta: float) -> void:
	var movement: float = Input.get_axis("move_left", "move_right")
	position.x += SPEED * delta * movement
	position.x = clampf(position.x, 45, get_viewport_rect().end.x-45)

func _on_area_entered(area: Area2D) -> void:
	print("Paddle Collide With Gem")
