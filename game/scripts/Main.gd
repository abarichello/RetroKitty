extends Node

var current_level = 0

func delete_game():
	var Game = get_node("/root/Main/Game")
	current_level = Game.gamemode
	Game.queue_free()
	$DeleteTimer.start()

func _on_DeleteTimer_timeout():
	var Menu = get_node("/root/Main/Menu")
	Menu.create_game_from_file(current_level + 1)
