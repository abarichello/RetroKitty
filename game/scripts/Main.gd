extends Node

var current_level = 0
var available_levels
var screensize = OS.get_screen_size()
var save_path = "user://RETROKITTY/"

func _ready():
    var save_dir = Directory.new()
    save_dir.change_dir("user://")
    save_dir.make_dir("RETROKITTY")

    random_loading_image()
    available_levels = $Menu/LevelMenu/VBox/LevelGrid.get_child_count()
    save_wallpapers(0)

func delete_game():
    var Game = get_node("/root/Main/Game")
    current_level = Game.gamemode
    Game.queue_free()

func random_loading_image():
    var total_images = 2
    randomize()
    var rand_index = randi() % total_images
    $LoadingBackground/Image.texture.set_region(Rect2(0, rand_index * 64, 64, 64))

func save_wallpapers(choice):
    var img = Image.new()
    if choice == 0:
        img.load("res://resources/img/wallpaper0.png")
        img.save_png(save_path + "retro_wallpaper.png")
    else:
        img.load("res://resources/img/wallpaper1.png")
        img.save_png(save_path + "thanks_for_playing.png")

# --- Timer ---

func start_loading_timer():
    random_loading_image()
    $LoadingTimer.start()

func start_quit_timer():
    $QuitTimer.start()

func _on_LoadingTimer_timeout():
    var Menu = get_node("/root/Main/Menu")
    if current_level < available_levels:
        Menu.create_game_from_file(current_level + 1)
    else:
        Menu.show_up()
        Menu.get_node('ThanksMenu').visible = true
        save_wallpapers(1)

func _on_QuitTimer_timeout():
    delete_game()
    get_node("/root/Main/Menu").show_up()
