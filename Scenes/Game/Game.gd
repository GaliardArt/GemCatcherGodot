extends Node2D


class_name Game


const EXPLODE = preload("res://assets/explode.wav")
const GEM = preload("res://Scenes/Gem/Gem.tscn")
const MARGIN: float = 70.0


@onready var spawn_timer: Timer = $SpawnTimer
@onready var paddle: Area2D = $Paddle
@onready var score_sound: AudioStreamPlayer2D = $ScoreSound
@onready var sound: AudioStreamPlayer = $Sound
@onready var score_label: Label = $ScoreLabel
@onready var gamer_over_label: Label = $GamerOverLabel


var _score: int = 0
static var _vp_r: Rect2


static func get_vpr() -> Rect2:
	return  _vp_r


func _ready() -> void:
	gamer_over_label.visible = false
	update_vp()
	get_viewport().size_changed.connect(update_vp)
	spawn_gem()


func update_vp() -> void:
	_vp_r = get_viewport_rect()


func spawn_gem() -> void:
	var new_gem: Gem = GEM.instantiate()
	var x_pos: float = randf_range(
		_vp_r.position.x + MARGIN,
		_vp_r.end.x - MARGIN
	)
	new_gem.position = Vector2(x_pos, -MARGIN)
	new_gem.gem_off_screen.connect(_on_gem_off_screen)
	add_child(new_gem)


func stop_all() -> void:
	sound.stop()
	sound.stream = EXPLODE
	gamer_over_label.visible = true
	sound.play()
	spawn_timer.stop()
	paddle.set_process(false)
	for child in get_children():
		if child is Gem:
			child.set_process(false)




func _on_paddle_area_entered(area: Area2D) -> void:
	_score += 1
	score_label.text = str(_score).pad_zeros(3)
	if score_sound.playing == false:
		score_sound.position = area.position
		score_sound.play()



func _on_gem_off_screen() -> void:
	stop_all()


func _on_timer_timeout() -> void:
	spawn_gem()
