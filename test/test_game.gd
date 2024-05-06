extends GutTest

var _sender = InputSender.new(Input)

var GameScene = preload("res://Game.tscn")
var GridScene = preload("res://Grid.tscn")
var TileScene = preload("res://Tile.tscn")

var game: Game
var grid: Grid
var tile: Tile

func before_each():
	game = add_child_autofree(GameScene.instantiate())
	# grid = add_child_autofree(partial_double(GridScene).instantiate())
#	tile = add_child_autofree(partial_double(TileScene).instantiate())

func after_each():
	_sender.release_all()
	_sender.clear()

func test_game_can_be_instantiated():
	assert_not_null(game)

func test_grid_creation():
	# Arrange
	var grid_size = 10

	# Act
	game = add_child_autofree(GameScene.instantiate())
	grid = game.make_new_grid(grid_size)

	# Assert
	assert_not_null(game.grid, "Grid node not found in Game node.")
	assert_eq(grid, game.grid)
	assert_eq(grid_size, grid.size, "Grid size does not match expected size.")
	assert_eq(grid.size * grid.size, grid.get_child_count(), "Incorrect number of tiles in grid.")
