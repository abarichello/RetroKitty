extends Area2D

enum Direction {UP = 90, DOWN = 270, LEFT = 180, RIGHT = 0}
var angle = 0
var alive = true
var hit_sound = load("res://resources/sounds/pong/pong1.ogg")

func _ready():
    $Sprite/Hitzone.monitoring = true
    right()

func fire():
    hit_bodies_in_hitzone()
    if angle == DOWN || angle == LEFT:
        self.rotation = -45
    else:
        self.rotation = 45
    $Cooldown.start()

func up():
    $Sprite.rotation = 0
    $Sprite.flip_v = false
    $Sprite.position = $Up.position
    angle = UP
    self.set_collision_layer_bit(angle, true)

func down():
    $Sprite.rotation = 0
    $Sprite.flip_v = true
    $Sprite.position = $Down.position
    angle = DOWN
    self.set_collision_layer_bit(angle, true)

func left():
    $Sprite.rotation = deg2rad(135)
    $Sprite.flip_v = true
    $Sprite.position = $Left.position
    angle = LEFT
    self.set_collision_layer_bit(angle, true)

func right():
    $Sprite.rotation = deg2rad(45)
    $Sprite.flip_v = false
    $Sprite.position = $Right.position
    angle = RIGHT
    self.set_collision_layer_bit(angle, true)

func hit_bodies_in_hitzone():
    var bodies = $Sprite/Hitzone.get_overlapping_bodies()
    for body in bodies:
        var able = $Cooldown.get_time_left() == 0
        if (body.angle == angle - 180 || body.angle == angle + 180) && able: # Bat and ball facing eachother
            body.set_collision_layer_bit(0, false)
            body.hit = true
            var direction = body.global_position - Vector2(1, 1)
            body.linear_velocity = direction * 5
            $Pong.play()
            if alive:
                var Hud = get_node("/root/Main/Game/GameHUD")
                Hud.hit_check(body)

func _on_Cooldown_timeout():
    self.rotation = 0
