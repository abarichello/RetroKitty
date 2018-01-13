extends RigidBody2D

var instructions = []
var instruction_no = 0
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
	if str(clock) == instructions[instruction_no][0] && !empty:
		var color = int(instructions[instruction_no][2])
		var speed = int(instructions[instruction_no][3])
		shoot(color, speed)
		if instruction_no == instructions.size()-1:
			empty = true
		else:
			instruction_no += 1

func shoot(color, speed):
	var ball = preload("res://scenes/Ball.tscn").instance()
	ball._ready(color, speed)
	add_child(ball)
	ball.create(self.global_position, angle)

func _on_Timer_timeout():
	clock += 0.1
