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

func _on_Bat_body_entered(body):
	if body.angle == angle - 180 || body.angle == angle + 180:
		body.queue_free()
