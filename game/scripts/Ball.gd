extends RigidBody2D

export (int) var min_speed = 125
export (int) var max_speed = 300
var angle

func create(start_position, angle):
	self.global_position = start_position
	self.angle = angle
	var direction = (get_node("/root/Main/Player").position - global_position).normalized()
	apply_impulse(Vector2(), direction * rand_range(min_speed, max_speed))

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
