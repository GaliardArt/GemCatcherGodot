extends Node2D

const GEM = preload("res://Scenes/Gem/Gem.tscn")
const MARGIN: float = 70.0
var _scoreCount: int = 0

@onready var spawn_timer: Timer = $Timer
@onready var score_sound: AudioStreamPlayer2D = $ScoreSound
@onready var sound: AudioStreamPlayer = $Sound
@onready var score: Label = $Score

const EXPLODE = preload("res://assets/explode.wav")


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
	sound.stop()
	sound.stream = EXPLODE
	sound.play()
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

func _on_paddle_area_entered(area: Area2D) -> void:
	_scoreCount += 1
	score.text = str(_scoreCount).pad_zeros(3)
	if score_sound.playing == false:
		score_sound.position = area.position
		score_sound.play()
