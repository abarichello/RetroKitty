extends KinematicBody2D

func _ready():
	global_position = get_node("/root/Main/Player").position

func _input(event):
	if event.is_action_pressed("ui_fire"):
		pass
