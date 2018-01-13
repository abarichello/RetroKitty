extends RigidBody2D

var instructions = []
var current_instruction = 0
var clock = 0.0
var empty = false
var angle

func setup(start_position, facing):
	self.global_position = start_position
	self.angle = facing

func _input(event):
	# DEBUG
	if event.is_action_pressed("ui_page_up") && randi() % 10 == 0:
		shoot()

func execute_instructions():
	if str(clock) == instructions[current_instruction][0] && !empty:
		shoot()
		if current_instruction == instructions.size()-1:
			empty = true
		else:
			current_instruction += 1

func shoot():
	var ball = preload("res://scenes/Ball.tscn").instance()
	add_child(ball)
	ball.create(self.global_position, angle)

func _on_Timer_timeout():
	clock += 0.1
