extends Area2D

onready var player = get_node("/root/Main/Player")
var angle

func _ready():
	global_position = player.global_position
	global_position.x += 150
	set_collision_layer_bit(0, true)
	set_collision_layer_bit(90, true)
	set_collision_layer_bit(180, true)
	set_collision_layer_bit(270, true)

func _process(delta):
	angle = player.angle
	if $Cooldown.get_time_left() > 0.8 && $Cooldown.get_time_left() < 1.0:
		$Sprite.color = Color(0, 0, 255)
	else:
		$Sprite.color = Color(255, 0, 0)

func _input(event):
	if event.is_action_pressed("ui_fire"):
		$Cooldown.start()

func _on_Bat_body_entered(body):
	var able = $Cooldown.get_time_left() > 0.8 && $Cooldown.get_time_left() < 1.0
	if (body.angle == angle - 180 || body.angle == angle + 180) && able:
		body.set_collision_layer_bit(0, false)
		body.add_force(Vector2(), -body.global_position * 5)
