extends Area2D

onready var Player = get_node("/root/Game/Main/Player")
onready var Hud = get_node("/root/Game/Main/GameHUD")
var angle
var alive = true

func _process(delta):
	angle = Player.angle
	if $Cooldown.get_time_left() > 0.1 && $Cooldown.get_time_left() < 0.3:
		$Sprite.self_modulate = Color(255, 0, 0)
	else:
		$Sprite.self_modulate = Color(0, 0, 255)

func _input(event):
	if alive:
		if event.is_action_pressed("ui_fire"):
			$Cooldown.start()
		if event.is_action_pressed("ui_up"):
			self.rotation = 0
			$Sprite.flip_v = false
			self.position = $Up.position
		if event.is_action_pressed("ui_down"):
			self.rotation = 0
			$Sprite.flip_v = true
			self.position = $Down.position
		if event.is_action_pressed("ui_left"):
			self.rotation = deg2rad(90)
			$Sprite.flip_v = true
			self.position = $Left.position
		if event.is_action_pressed("ui_right"):
			self.rotation = deg2rad(90)
			$Sprite.flip_v = false
			self.position = $Right.position

func _on_Bat_body_entered(body):
	var able = $Cooldown.get_time_left() > 0.1 && $Cooldown.get_time_left() < 0.3
	if (body.angle == angle - 180 || body.angle == angle + 180) && able: # Bat and ball facing eachother
		body.set_collision_layer_bit(0, false)
		body.hit = true
		var direction = body.global_position - Vector2(1, 1)
		body.linear_velocity = direction * 5
		Hud.hit_check(body)
