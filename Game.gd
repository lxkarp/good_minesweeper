extends Node2D
class_name Game

var grid : Grid

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func make_new_grid(size := 10):
	grid = Grid.new()
	grid.size = 10
	return grid
