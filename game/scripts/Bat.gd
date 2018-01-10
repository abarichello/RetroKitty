extends Area2D

onready var player = get_node("/root/Main/Player")
var angle

func _ready():
	position = player.position
	set_collision_layer_bit(0, true)
	set_collision_layer_bit(90, true)
	set_collision_layer_bit(180, true)
	set_collision_layer_bit(270, true)

func _process(delta):
	angle = player.angle
	if $Cooldown.get_time_left() > 0.1 && $Cooldown.get_time_left() < 0.3:
		$Sprite.color = Color(255, 0, 0)
	else:
		$Sprite.color = Color(0, 0, 255)

func _input(event):
	if event.is_action_pressed("ui_fire"):
		$Cooldown.start()

func _on_Bat_body_entered(body):
	var able = $Cooldown.get_time_left() > 0.1 && $Cooldown.get_time_left() < 0.3
	if (body.angle == angle - 180 || body.angle == angle + 180) && able:
		body.set_collision_layer_bit(0, false)
		var direction = body.global_position - Vector2(1, 1)
		body.linear_velocity = direction * 5
