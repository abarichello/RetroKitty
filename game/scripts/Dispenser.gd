extends RigidBody2D

var instructions = []
var angle

func setup(start_position, facing):
	self.global_position = start_position
	self.angle = facing

func _input(event):
	# DEBUG
	if event.is_action_pressed("ui_page_up") && randi() % 10 == 0:
		shoot()

func shoot():
	var ball = preload("res://scenes/Ball.tscn").instance()
	add_child(ball)
	ball.create(self.global_position, angle)
