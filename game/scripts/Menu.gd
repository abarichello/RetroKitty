extends Control

func _on_StartButton_pressed():
	interpret_file(1)

func interpret_file(level_number):
	var Game = preload("res://scenes/Main.tscn").instance()
	Game.gamemode = level_number
	var level = Game.load_level(level_number)
	
	# Transform file contents in arrays
	var level_array = []
	var arr = []
	var goal = []
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
	start_game(Game)

func start_game(Game):
	# Add game node as a sister of the Main menu
	var parent = get_parent()
	parent.add_child(Game)
	hide()
