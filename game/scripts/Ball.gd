extends RigidBody2D

signal out
enum Type {BLUE, GREEN, RED}

export (int) var min_speed = 75
export (int) var max_speed = 200
var speed
var hit
var angle
var color

func _ready(color, speed):
	hit = false
	self.color = color
	self.speed = speed
	match_color()

func _random_ready():
	hit = false
	randomize()
	self.color = randi() % Type.size()
	self.speed = rand_range(min_speed, max_speed)
	match_color()
	
func match_color():
	var color
	match self.color:
		0: color = Color(0, 0, 150) # Blue
		1: color = Color(0, 150, 0) # Green
		2: color = Color(150, 0, 0) # Red
	$Sprite.modulate = color
	return color

func _process(delta):
	$Sprite.rotation += max(abs(linear_velocity.x), abs(linear_velocity.y)) * delta / 350

func create(start_position, angle):
	self.global_position = start_position
	self.angle = angle
	self.set_collision_layer_bit(angle, true)
	var player = get_node("/root/Game/Main/Player")
	var direction = (player.position - global_position).normalized()
	apply_impulse(Vector2(), direction * speed)

func _on_VisibilityNotifier2D_screen_exited():
	if not hit:
		emit_signal("out")
	queue_free()

func _on_Ball_out():
	var hud = get_node("/root/Game/Main/GameHUD")
	hud.out_check(self)
