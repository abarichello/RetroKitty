extends Position2D

var screensize

func _ready():
	screensize = get_viewport_rect().size
	position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
