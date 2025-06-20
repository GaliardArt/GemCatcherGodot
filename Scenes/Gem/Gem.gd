extends Area2D

class_name Gem

signal gem_off_screen

const SPEED: float = 200.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position.y += SPEED * delta
	
	if position.y > Game.get_vpr().end.y:
		print("Gem falls off")
		gem_off_screen.emit()
		die()

func die() -> void:
	set_process(false)
	queue_free()
	
func _on_area_entered(area: Area2D) -> void:
	print("Gem hits paddle")
	die()
