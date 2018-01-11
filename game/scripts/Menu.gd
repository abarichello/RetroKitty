extends Control

func _on_StartButton_pressed():
	var game = preload("res://scenes/Main.tscn").instance()
	var node = get_parent()
	node.add_child(game)
	hide()
