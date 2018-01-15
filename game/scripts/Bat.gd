extends Area2D

onready var Player = get_node("/root/Game/Main/Player")
onready var Hud = get_node("/root/Game/Main/GameHUD")
var angle

func _process(delta):
	angle = Player.angle
	if $Cooldown.get_time_left() > 0.1 && $Cooldown.get_time_left() < 0.3:
		$Sprite.color = Color(255, 0, 0)
	else:
		$Sprite.color = Color(0, 0, 255)

func _input(event):
	if event.is_action_pressed("ui_fire"):
		$Cooldown.start()
	if event.is_action_pressed("ui_up"):
		self.rotation = deg2rad(90)
		self.position = $Up.position
	if event.is_action_pressed("ui_down"):
		self.rotation = deg2rad(90)
		self.position = $Down.position
	if event.is_action_pressed("ui_left"):
		self.rotation = 0
		self.position = $Left.position
	if event.is_action_pressed("ui_right"):
		self.rotation = 0
		self.position = $Right.position

func _on_Bat_body_entered(body):
	var able = $Cooldown.get_time_left() > 0.1 && $Cooldown.get_time_left() < 0.3
	if (body.angle == angle - 180 || body.angle == angle + 180) && able: # Bat and ball facing eachother
		body.set_collision_layer_bit(0, false)
		body.hit = true
		var direction = body.global_position - Vector2(1, 1)
		body.linear_velocity = direction * 5
		Hud.hit_check(body)
