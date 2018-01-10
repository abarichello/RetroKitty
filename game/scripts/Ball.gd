extends RigidBody2D

signal hit

enum Type {BLUE, GREEN, RED}

export (int) var min_speed = 200
export (int) var max_speed = 500
var angle
var color

func _ready():
	contact_monitor = true
	contacts_reported = 1
	
	color = randi() % Type.size()
	match [color]:
		[BLUE]:   $Sprite.modulate = Color(0, 0, 50)
		[GREEN]:  $Sprite.modulate = Color(0, 50, 0)
		[RED]:    $Sprite.modulate = Color(50, 0, 0)

func create(start_position, angle):
	self.global_position = start_position
	self.angle = angle
	self.set_collision_layer_bit(angle, true)
	var direction = (get_node("/root/Main/Player").position - global_position).normalized()
	apply_impulse(Vector2(), direction * rand_range(min_speed, max_speed))

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("hit")
	queue_free()

func _on_Ball_hit():
	pass
