extends RigidBody2D

signal out
enum Type {RED, ORANGE, YELLOW, GREEN, CYAN, BLUE, PURPLE, PINK, WHITE, BLACK}

export (float) var min_speed
export (float) var max_speed
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
		0: color = Color(150,   0, 0)   # RED
		1: color = Color(204, 102, 0)   # ORANGE
		2: color = Color(204, 204, 0)   # YELLOW
		3: color = Color(  0, 150, 0)   # GREEN
		4: color = Color(153, 153, 0)   # CYAN
		5: color = Color(  0,   0, 150) # BLUE
		6: color = Color(102,   0, 102) # PURPLE
		7: color = Color(255,   0, 255) # PINK
		8: color = Color(150, 150, 150) # WHITE
		9: color = Color(  0,   0,   0) # BLACK
		_: color = Color( 30,  30, 100) # MUD
	$Sprite.modulate = color
	return color

func _process(delta):
	$Sprite.rotation += max(abs(linear_velocity.x), abs(linear_velocity.y)) * delta / 350

func create(start_position, angle):
	self.global_position = start_position
	self.angle = angle
	self.set_collision_layer_bit(angle, true)
	var player = get_node("/root/Game/Main/Player")
	var direction = (player.global_position - global_position)
	apply_impulse(Vector2(), direction / self.speed)

func _on_VisibilityNotifier2D_screen_exited():
	if not hit:
		emit_signal("out")
	queue_free()

func _on_Ball_out():
	var hud = get_node("/root/Game/Main/GameHUD")
	hud.out_check(self)
