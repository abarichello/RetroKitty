extends RigidBody2D

var angle

func setup(start_position, angle):
	self.global_position = start_position
	self.angle = angle

func _process(delta):
	if (randi() % 300 == 0):
		var ball = preload("res://scenes/ball.tscn").instance()
		add_child(ball)
		ball.create(self.global_position, angle)
