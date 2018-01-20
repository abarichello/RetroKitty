extends Area2D

signal game_over
enum Direction {UP = 90, DOWN = 270, LEFT = 180, RIGHT = 0}

export (int) var max_hp = 3
var alive = true
var hp
var angle

func _ready():
	angle = UP
	hp = max_hp
	$Bat.position = $Bat/Up.position

func _process(delta):
	if hp <= 0:
		emit_signal("game_over")
	
func _input(event):
	if alive:
		if event.is_action_pressed("ui_up"):
			angle = UP
			$Sprite.flip_v = false 
		if event.is_action_pressed("ui_down"):
			angle = DOWN
			$Sprite.flip_v = true
		if event.is_action_pressed("ui_left"):
			angle = LEFT
			$Sprite.flip_h = true
		if event.is_action_pressed("ui_right"):
			angle = RIGHT
			$Sprite.flip_h = false

func _on_Player_game_over():
	print("game over")
	$Bat.alive = false
	self.alive = false
