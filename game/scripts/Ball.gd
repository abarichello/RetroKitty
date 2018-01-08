extends RigidBody2D

export (int) var speed = 300
var angle

func create(start_position, angle):
	self.global_position = start_position
	self.angle = angle
	var direction = get_node("/root/Main/Player").position - global_position
	apply_impulse(Vector2(), direction)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
