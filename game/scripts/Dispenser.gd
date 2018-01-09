extends RigidBody2D

var angle

func setup(start_position, facing):
	self.global_position = start_position
	self.angle = facing

func _input(event):
	if event.is_action_pressed("ui_page_up"):
		var ball = preload("res://scenes/Ball.tscn").instance()
		add_child(ball)
		ball.create(self.global_position, angle)

func _process(delta):
	#if (randi() % 300 == 0):
	#	var ball = preload("res://scenes/Ball.tscn").instance()
	#	add_child(ball)
	#	ball.create(self.global_position, angle)
	pass
