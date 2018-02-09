extends Node

var current_level = 0

func delete_game():
    var Game = get_node("/root/Main/Game")
    current_level = Game.gamemode
    Game.queue_free()
    # Show loading screen

# --- Timer ---

func start_loading_timer():
    $LoadingTimer.start()

func start_quit_timer():
    $QuitTimer.start()

func _on_LoadingTimer_timeout():
    var Menu = get_node("/root/Main/Menu")
    Menu.create_game_from_file(current_level + 1)

func _on_QuitTimer_timeout():
    delete_game()
    var Menu = get_node("/root/Main/Menu")
    Menu.show_up()
