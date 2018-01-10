extends Control

var correct_array = []

func _ready():
	correct_array.append($Ball1)
	correct_array.append($Ball2)
	correct_array.append($Ball3)
	#for ball in correct_array:
	#	ball.set_collision_layer_bit(0, false)
