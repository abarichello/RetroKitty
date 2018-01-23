extends RigidBody2D

signal empty

var instructions = []
var instruction_no = 0
var clock = 0.0
var empty = false
var angle

func _input(event):  # DEBUG
	if event.is_action_pressed("ui_page_up") && randi() % 10 == 0:
		random_ready()

func setup(start_position, facing):
	self.global_position = start_position
	self.angle = facing

func execute_instructions():
	if !empty && str(clock) == instructions[instruction_no][0]:
		var color = int(instructions[instruction_no][2])
		var speed = int(instructions[instruction_no][3])
		shoot(color, speed)
		if instruction_no == instructions.size()-1:
			emit_signal("empty")
			empty = true
		else:
			instruction_no += 1

func shoot(color, speed):
	var ball = preload("res://scenes/Ball.tscn").instance()
	ball._ready(color, speed)
	add_child(ball)
	$Sprite.self_modulate = ball.match_color()
	$ColorTimer.start()
	$Sprite.frame = 0
	$Sprite.frames.set_animation_speed("default", speed / 2)
	$Sprite.play("default")
	ball.create(self.global_position, self.angle)

func _on_Timer_timeout():
	clock += 0.1

func _on_ColorTimer_timeout():  # Return to original color
	$Sprite.self_modulate = Color(1, 1, 1)

func _on_Dispenser_empty(): # Slide locked back
	$Sprite.stop()
	$Sprite.frame = 10
