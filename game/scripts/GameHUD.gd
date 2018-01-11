extends Control

onready var player = get_node("/root/Game/Main/Player")
var correct_array = []
var balls_hit = 0

func _ready():
	correct_array.append($CorrectPanel/Ball1)
	correct_array.append($CorrectPanel/Ball2)
	correct_array.append($CorrectPanel/Ball3)

func _process(delta):
	if balls_hit == correct_array.size():
		game_over()
	
	$CorrectPanel/ProgressBar.value = player.hp
	$CorrectPanel/ProgressBar.margin_right = 350
	$CorrectPanel/ProgressBar.margin_bottom = 20

func game_over():
	print("--GAME ENDED--")

func hit_check(ball):
	if ball.color == correct_array[balls_hit].color:
		get_child(0).get_child(balls_hit).modulate = Color(0, 0, 0, 50)
		balls_hit += 1
		print('NICE')
	else:
		player.hp -= 1

func out_check(ball):
	if balls_hit < correct_array.size() && ball.color == correct_array[balls_hit].color:
		player.hp -= 1
