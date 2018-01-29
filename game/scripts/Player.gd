extends Area2D

signal game_over
signal round_ended
enum Direction {UP = 90, DOWN = 270, LEFT = 180, RIGHT = 0}

export (int) var max_hp = 3
var alive = true
var hp
var angle

func _ready():
	angle = UP
	hp = max_hp

func _process(delta):
	if hp <= 0:
		emit_signal("game_over")
	
func _input(event):
	if event.is_action_pressed("ui_up"):
		angle = UP
	if event.is_action_pressed("ui_down"):
		angle = DOWN
	if event.is_action_pressed("ui_left"):
		angle = LEFT
		$Sprite.flip_h = true
	if event.is_action_pressed("ui_right"):
		angle = RIGHT
		$Sprite.flip_h = false

func game_over():
	print("game over")
	$Bat.alive = false
	# lose animation

func round_ended():
	print("round ended!")
	$Bat.alive = false
	# win animation

# --- Signals ---

func _on_Player_game_over():
	game_over()

func _on_Player_round_ended():
	round_ended()
