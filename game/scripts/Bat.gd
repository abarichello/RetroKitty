extends Area2D

enum Direction {UP = 90, DOWN = 270, LEFT = 180, RIGHT = 0}
onready var Player = get_node("/root/Game/Main/Player")
onready var Hud = get_node("/root/Game/Main/GameHUD")
var angle = 0
var alive = true

func _ready():
	$Sprite/Hitzone.monitoring = true

func _process(delta):
	if Player:
		angle = Player.angle

func _input(event):
	if alive:
		if event.is_action_pressed("ui_fire"):
			hit_bodies_in_hitzone()
			$Cooldown.start()
		if event.is_action_pressed("ui_up"):
			$Sprite.rotation = 0
			$Sprite.flip_v = false
			$Sprite.position = $Up.position
			angle = UP
			self.set_collision_layer_bit(angle, true)
		if event.is_action_pressed("ui_down"):
			$Sprite.rotation = 0
			$Sprite.flip_v = true
			$Sprite.position = $Down.position
			angle = DOWN
			self.set_collision_layer_bit(angle, true)
		if event.is_action_pressed("ui_left"):
			$Sprite.rotation = deg2rad(135)
			$Sprite.flip_v = true
			$Sprite.position = $Left.position
			angle = LEFT
			self.set_collision_layer_bit(angle, true)
		if event.is_action_pressed("ui_right"):
			$Sprite.rotation = deg2rad(45)
			$Sprite.flip_v = false
			$Sprite.position = $Right.position
			angle = RIGHT
			self.set_collision_layer_bit(angle, true)

func hit_bodies_in_hitzone():
	var bodies = $Sprite/Hitzone.get_overlapping_bodies()
	for body in bodies:
		var able = $Cooldown.get_time_left() == 0
		if (body.angle == angle - 180 || body.angle == angle + 180) && able: # Bat and ball facing eachother
			body.set_collision_layer_bit(0, false)
			body.hit = true
			var direction = body.global_position - Vector2(1, 1)
			body.linear_velocity = direction * 5
			Hud.hit_check(body)
