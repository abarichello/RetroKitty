extends Node

const UP = 90
const DOWN = 270
const LEFT = 180
const RIGHT = 0

export (PackedScene) var dispenser
var level_array = []
var goal_array = []
var gamemode = 0 # 0 - Random, Else - Scripted
var uptime = 0.0
var times_shaken = 0

var level_title = ""
var screensize

func _ready():
    screensize = get_node("/root").get_viewport().get_visible_rect().size

    $Player/SpawnPosition.position = screensize / 2
    $Player.position = $Player/SpawnPosition.position
    setup_dispensers()

func _process(delta):
    var empty_dispensers = 0
    for i in range(0, $Dispensers.get_child_count()):
        var no_children = $Dispensers.get_child(i).children == 0
        if $Dispensers.get_child(i).empty && no_children:
            empty_dispensers += 1
    if empty_dispensers == 4:
        $Player.emit_signal("game_over")

    match gamemode:
        0: random()
        _: level()

func _on_StartCountdown_timeout():
    $GameHUD/Title.hide()
    for i in range(0, $Dispensers.get_child_count()):
        $Dispensers.get_child(i).power_on()

# --- Dispenser Management ---

func setup_dispensers():
    var father = get_node("Dispensers")
    var disp_width = $Dispensers/Dispenser1/Sprite.frames.get_frame("default", 0).get_width()
    var player_x = $Player.position.x
    var player_y = $Player.position.y

    # Up
    var dispenser1 = father.get_child(0)
    dispenser1.setup(Vector2(player_x, player_y - player_x / 1.1), DOWN)
    dispenser1.get_child(0).rotation = deg2rad(90)

    # Down
    var dispenser2 = father.get_child(1)
    dispenser2.setup(Vector2(player_x, player_y + player_x / 1.1), UP)
    dispenser2.get_child(0).rotation = deg2rad(270)

    # Left
    var dispenser3 = father.get_child(2)
    dispenser3.setup(Vector2(disp_width / 2, player_y), RIGHT)
    dispenser3.get_child(0).flip_h = false

    # Right
    var dispenser4 = father.get_child(3)
    dispenser4.setup(Vector2(screensize.x - disp_width / 2, player_y), LEFT)
    dispenser4.get_child(0).flip_h = true

func set_dispensers_gamemode(gamemode):
    for i in range(0, $Dispensers.get_child_count()):
        $Dispensers.get_child(i).gamemode = gamemode

func delete_balls():
    for i in range(0, $Dispensers.get_child_count()):
        $Dispensers.get_child(i).delete_children()

func random():  # Dispensers random mode
    for i in range(0, $Dispensers.get_child_count()):
        var dispenser = get_node("Dispensers").get_child(i)
        var dispenser_timer = dispenser.get_node("Cooldown")
        randomize()
        if randi() % 97 == 0 && dispenser_timer.get_time_left() == 0:
            var ball = preload("res://scenes/Ball.tscn").instance()

            randomize()
            var color = randi() % ball.Type.size()
            if randi() % 5 == 0:  # Shoot next ball in goal
                var hud = get_node("/root/Main/Game/GameHUD")
                color = hud.correct_array[hud.balls_hit].color

            var speed = rand_range(ball.min_speed, ball.max_speed)
            dispenser_timer.start()
            dispenser.shoot(color, speed)

func level():  # Check each dispenser instruction for execution
    var father = get_node("Dispensers")
    var dispenser_no = father.get_child_count()
    for i in range(0, dispenser_no):
        var disp = father.get_child(i)
        if disp.instructions.size() != 0:
            disp.execute_instructions()

# --- Level and Goal Management ---

func extract_level(level_number):
    # Reads and treats the contents of *.lvl files
    var level = File.new()
    level.open("res://levels/level" + "_" + str(level_number) + ".lvl", File.READ)
    var content = ""
    while not level.eof_reached():
        var line = level.get_line()
        if line.begins_with("#"): # Remove comments
            pass
        elif line.begins_with("$"):
            extract_goal(line)
            print(goal_array)
        elif line.begins_with("&"):
            extract_title(line)
            $GameHUD/Title.text = level_title
            print(level_title)
        else:
            content += line + "\n"
    level.close()
    return content

func extract_goal(line):
    for c in line:
        if c != "$" and c != "\n" and c != " ":
            goal_array.append(int(c))

func extract_title(line):
    for c in line:
        if c != "&":
            level_title += c

func load_dispensers():  # Loads dispensers with instructions arrays
    for array in level_array:
        var dispenser_no = int(array[1])
        var disp = $Dispensers.get_child(dispenser_no)
        disp.instructions.append(array)

func load_random_goal():  # Creates a goal array and sends to HUD
    goal_array = []
    for i in range(0, 5):
        var ball = preload("res://scenes/Ball.tscn").instance()
        ball._random_ready()
        goal_array.append(ball.color)
    $GameHUD._ready(goal_array)

func load_goal():  # Sends the extracted goal array to HUD
    $GameHUD._ready(goal_array)

# --- Timers ---

func start_shaking():
    $ShakeTimer.start()

func _on_ShakeTimer_timeout():
    $Player/Sprite.play("Hurt")
    randomize()
    var random_offset = Vector2(rand_range(-7, 7), rand_range(-7, 7))
    $Player.position += random_offset
    times_shaken += 1

    if times_shaken >= 10:
        times_shaken = 0
        $ShakeTimer.stop()
        $Player.position = $Player/SpawnPosition.position
        $Player/Sprite.play("Idle")

func _on_Uptime_timeout():
    uptime += 0.1
