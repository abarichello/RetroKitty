extends Area2D

signal hit

onready var main = self.get_node("/root/Main")
enum Direction {UP = 1, DOWN = 2, LEFT = 3, RIGHT = 4}
export (int) var max_hp = 3
var screensize
var hp
var facing

func _ready():
	facing = UP
	hp = max_hp
	screensize = get_viewport_rect().size

func _process(delta):
	if hp <= 0:
		game_over()
	
	# Movement
	if Input.is_action_pressed("ui_up"):
		facing = UP
		$Sprite.flip_v = false
	if Input.is_action_pressed("ui_down"):
		facing = DOWN
		$Sprite.flip_v = true
	if Input.is_action_pressed("ui_left"):
		facing = LEFT
		$Sprite.flip_h = true
	if Input.is_action_pressed("ui_right"):
		facing = RIGHT
		$Sprite.flip_h = false

func game_over():
	queue_free()
