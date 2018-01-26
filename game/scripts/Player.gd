extends Area2D

signal game_over
onready var Hud = get_node("/root/Game/Main/GameHUD")
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
	if alive:
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

func _on_Player_game_over():
	print("game over")
	$Bat.alive = false
	self.alive = false

func _on_Player_body_entered(body):
	print(body)
	var able = $Bat/Cooldown.get_time_left() > 0.1 && $Bat/Cooldown.get_time_left() < 0.3
	if (body.angle == angle - 180 || body.angle == angle + 180) && able: # Bat and ball facing eachother
		body.set_collision_layer_bit(0, false)
		body.hit = true
		var direction = body.global_position - Vector2(1, 1)
		body.linear_velocity = direction * 5
		Hud.hit_check(body)
