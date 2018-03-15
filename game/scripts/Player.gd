extends Area2D

signal game_over
signal round_ended
enum Direction {UP = 90, DOWN = 270, LEFT = 180, RIGHT = 0}

export (int) var max_hp = 3
var alive = true
var hp
var angle

func _ready():
    angle = UP
    hp = max_hp

func _process(delta):
    if hp <= 0:
        emit_signal("game_over")

func _input(event):
    if event.is_action_pressed("ui_fire"):
        fire()
    if event.is_action_pressed("ui_up"):
        up()
    if event.is_action_pressed("ui_down"):
        down()
    if event.is_action_pressed("ui_left"):
        left()
    if event.is_action_pressed("ui_right"):
        right()

func up():
    angle = UP
    $Bat.up()

func down():
    angle = DOWN
    $Bat.down()

func left():
    angle = LEFT
    $Sprite.flip_h = true
    $Bat.left()

func right():
    angle = RIGHT
    $Sprite.flip_h = false
    $Bat.right()

func fire():
    $Bat.fire()

func game_over():
    print("game over")
    disconnect("round_ended", self, "_on_Player_round_ended")
    $Bat.right()
    $Bat.alive = false
    $Sprite.play("Hurt")  # Lose animation
    get_node("/root/Main").start_quit_timer()

func round_ended():
    print("round ended!")
    disconnect("game_over", self, "_on_Player_game_over")
    $Bat.right()
    $Bat.alive = false
    $Sprite.play("Win")  # Win animation

# --- Signals ---

func _on_Player_game_over():
    game_over()

func _on_Player_round_ended():
    round_ended()
