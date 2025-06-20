extends Area2D

const SPEED: float = 460.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	#if Input.is_action_pressed("move_left") == true:
	#	position.x -= SPEED * delta
	#if Input.is_action_pressed("move_right") == true:
	#	position.x += SPEED * delta
	
	var movement: float = Input.get_axis("move_left", "move_right")
	position.x += SPEED * delta * movement
		
	position.x = clampf(
		position.x,
		Game.get_vpr().position.x,
		Game.get_vpr().end.x
	)

func _on_area_entered(area: Area2D) -> void:
	print("_on_area_entered from Paddle Definiton")
