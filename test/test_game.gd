extends GutTest

var _sender = InputSender.new(Input)

var GameScene = preload("res://Game.tscn")
var GridScene = preload("res://Grid.tscn")
var TileScene = preload("res://Tile.tscn")

var game: Node
var grid: Node
var tile: Node

 func before_each():
	game = add_child_autofree(GameScene.instantiate())
	# grid = add_child_autofree(partial_double(GridScene).instantiate())
#	tile = add_child_autofree(partial_double(TileScene).instantiate())

func after_each():
	_sender.release_all()
	_sender.clear()

func test_game_can_be_instantiated():
	game = add_child_autofree(GameScene.instantiate())
	assert_true(true)

func test_grid_creation():
	# Arrange
	var grid_size = 10

	# Act
	game = add_child_autofree(GameScene.instantiate())
	grid = game.new_grid(grid_size)

	# Assert
	assert_not_nil(grid, "Grid node not found in Game node.")
	assert_equal(grid_size, grid.size, "Grid size does not match expected size.")
	assert_equal(grid_size * grid_size, grid.get_child_count(), "Incorrect number of tiles in grid.")
