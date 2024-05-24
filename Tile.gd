extends Node2D
class_name Tile

var grid_position : Vector2
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var clicked : bool

# TODO - replace these with real sizes from Sprite objects
const TILE_SIZE = 159.0
const TILE_SPACING = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	# var tween = create_tween()
	var desired_tile_position = Vector2(grid_position.x * (TILE_SIZE + TILE_SPACING), grid_position.y * (TILE_SIZE + TILE_SPACING))
	# tween.tween_property(self, "position", desired_tile_position, 1)
	position = desired_tile_position
	sprite.frame = randi() % 11

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if clicked == null:
		clicked = false
	if clicked != false:
		print("clicked: ", clicked)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and not event.is_echo() and event.button_index == MOUSE_BUTTON_LEFT:
		var current_animation = sprite.animation
		var current_frame = sprite.frame
		var current_texture = sprite.sprite_frames.get_frame_texture(current_animation, current_frame)
		var current_rect = current_texture.get_image().get_used_rect()
		print(event.position)
		print(current_rect)
		if current_rect.has_point(event.position):
			print("piss!")
			clicked = true
			print(clicked)
			get_viewport().set_input_as_handled() # if you don't want subsequent input callbacks to respond to this input
