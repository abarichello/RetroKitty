extends Control

var Game = preload("res://scenes/Main.tscn").instance()

func _on_Level_pressed():
	create_game_from_file(1)
	Game.load_goal()

func _on_Random_pressed():
	create_random_game()
	Game.load_random_goal()

func create_random_game():
	Game.gamemode = 0
	start_game(Game)

func create_game_from_file(level_number):
	Game.gamemode = level_number
	var level = Game.extract_level(level_number)
	Game.level_array = interpret_file(level)
	Game.load_dispensers()
	start_game(Game)

func interpret_file(level):  # Transform file contents in arrays
	var level_array = []
	var arr = []
	var goal = []
	var word = ""
	for character in level:
		if arr.size() == 4: # Number of columns
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
	return level_array

func start_game(Game):
	# Add game node as a sister of the Main menu
	var parent = get_parent()
	parent.add_child(Game)
	hide()
