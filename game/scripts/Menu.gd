extends Control

var Game = preload("res://scenes/Game.tscn").instance()
onready var popup = get_node("LevelMenu")
onready var about_menu = get_node("AboutMenu")
var unlocked_levels = [1]
var saved_game = File.new()
var save_path = "user://savefile.sv"

func _ready():
    pass
    #load_save()

func create_random_game():
    Game = preload("res://scenes/Game.tscn").instance()
    Game.gamemode = 0
    Game.set_dispensers_gamemode(0)
    start_game(Game)

func create_game_from_file(level_number):
    Game = preload("res://scenes/Game.tscn").instance()
    Game.gamemode = level_number
    Game.set_dispensers_gamemode(level_number)

    var level = Game.extract_level(level_number)
    Game.level_array = interpret_file(level)
    Game.load_dispensers()
    start_game(Game)
    Game.load_goal()

    unlock_level(level_number)
    save_game()

func start_game(Game):  # Add game node as a sister of the Main menu
    var parent = get_parent()
    parent.add_child(Game)
    hide()

func interpret_file(level):  # Transform file contents in arrays
    var level_array = []
    var arr = []
    var goal = []
    var word = ""
    for character in level:
        var number_of_columns = 4
        if arr.size() == number_of_columns:
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

# --- Save System ---

func save_game():  # Serialize Menu node
    saved_game = File.new()
    saved_game.open(save_path, File.WRITE)

    var save_data = ""
    for i in unlocked_levels.size():
        save_data += str(unlocked_levels[i])

    saved_game.store_var({"unlockedlevels": unlocked_levels})
    saved_game.close()

func read_saved_game():
    var saved_data = ""
    if saved_game.file_exists(save_path):
        var saved_game = File.new()
        saved_game.open(save_path, File.READ)
        saved_data = saved_game.get_var()
        print("Loaded save:")
        print(saved_data)
        saved_game.close()
    else:
        save_game()
    return saved_data

func load_save():
    var saved_data = read_saved_game()
    if !saved_data.empty():
        var arr = saved_data["unlockedlevels"]
        for i in range(0, arr.size()):
            unlock_level(arr[i])

func unlock_level(level_number):
    get_node("LevelMenu/VBox/LevelGrid").get_child(level_number - 1).disabled = false
    if !unlocked_levels.has(level_number):
        unlocked_levels.append(level_number)

func lock_levels():
    var level_grid = get_node("LevelMenu/VBox/LevelGrid")
    var total_levels = level_grid.get_child_count()
    for i in range(1, total_levels):
        level_grid.get_child(i).disabled = true

func delete_save():
    saved_game.open(save_path, File.WRITE)
    saved_game.store_var("")
    saved_game.close()
    lock_levels()

# --- Visibility ---

func show_up():
    var player = preload("res://scenes/Player.tscn").instance()
    player.position = Vector2(149, 537)
    player.scale = Vector2(4.7, 4.7)
    $Out/Fluff.add_child(player)
    show()

# --- Menu Sinals ---
# Start submenu

func _on_Start_pressed():
    popup.visible = true
    popup.rect_position = Vector2(62, 132)
    popup.rect_size = Vector2(761, 1368)

func _on_X_pressed():
    popup.hide()

func _on_Level1_pressed():
    create_game_from_file(1)
    button_pressed()

func _on_Level2_pressed():
    create_game_from_file(2)
    button_pressed()

func _on_Level3_pressed():
    create_game_from_file(3)
    button_pressed()

func _on_Level4_pressed():
    create_game_from_file(4)
    button_pressed()

func _on_Level5_pressed():
    create_game_from_file(5)
    button_pressed()

func _on_Level6_pressed():
    create_game_from_file(6)
    button_pressed()

func _on_Random_pressed():
    create_random_game()
    Game.load_random_goal()
    button_pressed()

func button_pressed():  # Function to be called after a relevant bt press
    popup.hide()
    get_node("Out/Fluff/Player").queue_free()

# About sub-menu

func _on_About_pressed():
    about_menu.show()

func _on_X2_pressed():
    about_menu.hide()

func _on_Delete_Save_pressed():
    delete_save()

# --- Social media buttons ---

func _on_Twitter_pressed():
    OS.shell_open("https://twitter.com/a_barichello")

func _on_GitHub_pressed():
    OS.shell_open("https://github.com/abarichello/bat-hit-ball")

func _on_Telegram_pressed():
    OS.shell_open("https://t.me/abarichello")
