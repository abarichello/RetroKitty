extends Control

func _on_StartButton_pressed():
	var Game = preload("res://scenes/Main.tscn").instance()
	var level_number = 1
	Game.gamemode = level_number
	var level = Game.load_level(level_number)
	
	# Transform file contents in arrays
	var level_array = []
	var arr = []
	var word = ""
	for character in level:
		if arr.size() == 4:
			level_array.append(arr)
			arr = []
		if character.is_valid_integer() || character == ".":
			word += character
		elif character == "\n" || character == "" || character == " ":
			if !word.empty():
				arr.append(word)
			word = ""
	level_array.append(arr)
	
	print(level_array) # DEBUG
	Game.level_array = level_array
	Game.load_dispensers()
	
	# Add game node as a sister of the Main menu
	var parent = get_parent()
	parent.add_child(Game)
	hide()
