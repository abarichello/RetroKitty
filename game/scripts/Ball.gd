extends RigidBody2D

signal out
enum Type {RED, ORANGE, YELLOW, GREEN, CYAN, BLUE, PURPLE, PINK, WHITE, BLACK}

var texture_path = "res://resources/img/ball/"

export (float) var min_speed
export (float) var max_speed
var speed
var hit
var angle
var color

func _ready(color, speed):
    hit = false
    self.color = color
    self.speed = speed
    match_color()

func _random_ready():
    hit = false
    randomize()
    self.color = randi() % Type.size()
    self.speed = rand_range(min_speed, max_speed)
    match_color()

func match_color():
    var color
    match self.color:
        0:
            color = Color(   1,   0,   0) # RED
            var red_texture = load(texture_path + "red.png")
            $Sprite.set_texture(red_texture)
        1:
            color = Color( .84, .55, .17) # ORANGE
            var orange_texture = load(texture_path + "orange.png")
            $Sprite.set_texture(orange_texture)
        2:
            color = Color( .97,   1,  .2) # YELLOW
            var yellow_texture = load(texture_path + "yellow.png")
            $Sprite.set_texture(yellow_texture)
        3:
            color = Color(   0,   1,   0) # GREEN
            var green_texture = load(texture_path + "green.png")
            $Sprite.set_texture(green_texture)
        4:
            color = Color(  .5,  .8,   1) # CYAN
            var cyan_texture = load(texture_path + "cyan.png")
            $Sprite.set_texture(cyan_texture)
        5:
            color = Color(   0,   0, .85) # BLUE
            var blue_texture = load(texture_path + "blue.png")
            $Sprite.set_texture(blue_texture)
        6:
            color = Color(  .3,   0,  .8) # PURPLE
            var purple_texture = load(texture_path + "purple.png")
            $Sprite.set_texture(purple_texture)
        7:
            color = Color(   1,   0, .91) # PINK
            var pink_texture = load(texture_path + "pink.png")
            $Sprite.set_texture(pink_texture)
        8:
            color = Color(   1,   1,   1) # WHITE
        9:
            color = Color( .45, .45, .45) # BLACK
            var black_texture = load(texture_path + "black.png")
            $Sprite.set_texture(black_texture)
        _:
            color = Color( .57, 102, .63) # MUD

    $Sprite.modulate = color
    return color

func create(start_position, angle):
    self.global_position = start_position
    self.angle = angle
    self.set_collision_layer_bit(angle, true)

    var player = get_node("/root/Main/Game/Player")
    var direction = (player.global_position - self.global_position)
    apply_impulse(Vector2(), direction / self.speed)

# --- Signals ---

func _on_VisibilityNotifier2D_screen_exited():
    if not hit:
        emit_signal("out")
    queue_free()

func _on_Ball_out():
    var hud = get_node("/root/Main/Game/GameHUD")
    hud.out_check(self)
