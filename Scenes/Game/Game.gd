extends Node2D

const GEM = preload("res://Scenes/Gem/Gem.tscn")
const MARGIN: float = 70.0
@onready var spawn_timer: Timer = $Timer

func _ready() -> void:
	spawn_gem()
	
func spawn_gem() -> void:
	var new_gem: Gem = GEM.instantiate()
	var x_pos: float = randf_range(
		get_viewport_rect().position.x + MARGIN, 
		get_viewport_rect().end.x - MARGIN
	)
	new_gem.position = Vector2(x_pos, -50.0)
	new_gem.gem_off_screen.connect(_on_gem_off_screen)
	add_child(new_gem)
	pass

func stop_all() -> void:
	spawn_timer.stop()
	for child in get_children():
		if child is Gem or child is Paddle:
			child.set_process(false)

func _on_gem_off_screen() -> void:
	stop_all()
	pass # Replace with function body.

func _on_timer_timeout() -> void:
	spawn_gem()
	pass # Replace with function body.
