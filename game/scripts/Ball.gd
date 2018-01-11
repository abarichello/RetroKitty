extends RigidBody2D

signal out
enum Type {BLUE, GREEN, RED}

export (int) var min_speed = 200
export (int) var max_speed = 500
var hit = false
var angle
var color

func _ready():
	randomize()
	contact_monitor = true
	contacts_reported = 1
	
	color = Type.keys()[randi() % Type.size()]
	match [color]:
		['BLUE']:   $Sprite.modulate = Color(0, 0, 50)
		['GREEN']:  $Sprite.modulate = Color(0, 50, 0)
		['RED']:    $Sprite.modulate = Color(50, 0, 0)

func _process(delta):
	$Sprite.rotation += deg2rad(27) * max(abs(linear_velocity.x), abs(linear_velocity.y)) * delta

func create(start_position, angle):
	self.global_position = start_position
	self.angle = angle
	self.set_collision_layer_bit(angle, true)
	var direction = (get_node("/root/Game/Main/Player").position - global_position).normalized()
	hit = true
	apply_impulse(Vector2(), direction * rand_range(min_speed, max_speed))

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("out")
	queue_free()

func _on_Ball_out():
	if hit:
		var hud = get_node("/root/Game/Main/GameHUD")
		hud.out_check(self)
