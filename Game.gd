extends Node2D
class_name Game

var grid : Grid

# Called when the node enters the scene tree for the first time.
func _ready():
	make_new_grid()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func make_new_grid(size := 10):
	if is_instance_valid(grid):
		grid.queue_free()

	grid = Grid.new()
	grid.size = size
	grid.populate_tiles()
	add_child(grid)
	return grid
