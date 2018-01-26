extends Area2D

onready var Player = get_node("/root/Game/Main/Player")
var angle
var alive = true

func _process(delta):
	if Player:
		angle = Player.angle

func _input(event):
	if alive:
		if event.is_action_pressed("ui_fire"):
			$Cooldown.start()
		if event.is_action_pressed("ui_up"):
			$Sprite.rotation = 0
			$Sprite.flip_v = false
			$Sprite.position = $Up.position
		if event.is_action_pressed("ui_down"):
			$Sprite.rotation = 0
			$Sprite.flip_v = true
			$Sprite.position = $Down.position
		if event.is_action_pressed("ui_left"):
			$Sprite.rotation = deg2rad(135)
			$Sprite.flip_v = true
			$Sprite.position = $Left.position
		if event.is_action_pressed("ui_right"):
			$Sprite.rotation = deg2rad(45)
			$Sprite.flip_v = false
			$Sprite.position = $Right.position
