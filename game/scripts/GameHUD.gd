extends Control

signal game_over

onready var player = get_node("/root/Game/Main/Player")
var correct_array = []
var balls_hit = 0
var goal_number

func _ready(goal_array):
	self.goal_number = goal_array.size()
	$CorrectPanel/ProgressBar.value = player.hp
	$CorrectPanel/ProgressBar.margin_right = 350
	
	for i in range(0, goal_number):
		var ball = preload("res://scenes/Ball.tscn").instance()
		randomize()
		var color = int(goal_array[i])
		ball._ready(color, 0)
		$CorrectPanel/HBox.add_child(ball)
		correct_array.append(ball)

func _process(delta):
	$CorrectPanel/ProgressBar.margin_bottom = 20
	if balls_hit == correct_array.size():
		game_over()

func game_over():
	emit_signal("game_over")
	print("--GAME ENDED--")

func hit_check(ball):
	if ball.color == correct_array[balls_hit].color:
		get_node('CorrectPanel/HBox').get_child(balls_hit).modulate = Color(0, 0, 0, 50)
		balls_hit += 1
	else:
		player.hp -= 1

func out_check(ball):
	if balls_hit < correct_array.size() && ball.color == correct_array[balls_hit].color:
		player.hp -= 1

func organize():
	for i in range(0, goal_number):
		pass
