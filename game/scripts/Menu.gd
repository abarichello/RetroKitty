extends Control

func _on_StartButton_pressed():
	var Game = preload("res://scenes/Main.tscn").instance()
	Game.gamemode = 0
	var level = Game.load_level(1)
	
	# Transform file contents in arrays
	var level_array = []
	var arr = []
	var word = ""
	for character in level:
		if arr.size() == 4:
			level_array.append(arr)
			arr = []
		if character != " " && character != "\n":
			word += character
		else:
			arr.append(word)
			word = ""
	level_array.append(arr)
	Game.level_array = level_array
	
	# Add game node as a sister of the Main menu
	var parent = get_parent()
	parent.add_child(Game)
	hide()
