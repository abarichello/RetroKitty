extends Control

func _on_StartButton_pressed():
	var Game = preload("res://scenes/Main.tscn").instance()
	Game.gamemode = 0
	var level = Game.load_level(1)
	print(level)
	
	var parent = get_parent()
	# Add game node as a sister of the Main menu
	parent.add_child(Game)
	hide()
