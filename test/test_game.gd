extends GutTest

var _sender = InputSender.new(Input)

var GameScene = preload("res://Game.tscn")
var GridScene = preload("res://Grid.tscn")
var TileScene = preload("res://Tile.tscn")

var game             : Game
var grid             : Grid
var tile             : Tile
var a_different_tile : Tile
var tiles            : Array
var grid_size        : int    = 10

var half_grid_size : int = (grid_size / 2)-1

var test_position_list = [
	Vector2i(0, 0),

	Vector2i(grid_size-1, 0),
	Vector2i(grid_size-1, grid_size-1),
	Vector2i(0, grid_size-1),

	Vector2i(half_grid_size, half_grid_size),
	Vector2i(0, half_grid_size),
	Vector2i(half_grid_size, 0),
	]

var bad_position_list = [
	Vector2(10, 0),
	]

var expected_tile_sprites = ["hidden", "clear"]

func before_each():
	game = add_child_autofree(GameScene.instantiate())
	grid = game.make_new_grid(grid_size)
	await get_tree().create_timer(.1).timeout
	tile = grid.get_tile_at_position(0, 0)
	a_different_tile = grid.get_tile_at_position(5, 5)
	# grid = add_child_autofree(partial_double(GridScene).instantiate())
#	tile = add_child_autofree(partial_double(TileScene).instantiate())

func after_each():
	_sender.release_all()
	_sender.clear()

func test_game_can_be_instantiated():
	assert_not_null(game)

func test_grid_creation():
	assert_not_null(game.grid, "Grid node not found in Game node.")
	assert_eq(grid, game.grid)
	assert_eq(grid_size, grid.size, "Grid size does not match expected size.")
	assert_eq(grid.get_child_count(), grid.size * grid.size, "Incorrect number of tiles in grid.")
	assert_eq(grid.get_tiles().size(), grid.size * grid.size, "Incorrect number of tiles in grid.")
	assert_true(grid.is_inside_tree(), "Grid is not in the main scene tree after being created")

func test_tile_in_grid_initialization():
	# Act
	tiles = grid.tiles

	# Assert
	assert_not_null(tiles, "Grid tiles not initialized.")
	assert_eq(grid_size, tiles.size(), "Incorrect number of rows in the grid.")
	for row in tiles:
		assert_eq(grid_size, row.size(), "Incorrect number of columns in the grid.")
		for t in row:
			assert_is(t, Tile, "Invalid tile type.")

func test_get_tile_at_position(position : Vector2 = use_parameters(test_position_list)):
	# Arrange
	grid_size = 10
	game = Game.new()
	grid = game.make_new_grid(grid_size)

	# Act
	tile = grid.get_tile_at_position(position.x, position.y)

	# Assert
	assert_not_null(tile, "Tile at position {0} not found.".format([position]))
	assert_is(tile, Tile, "Invalid tile type.")

func test_tile_knows_position(position : Vector2 = use_parameters(test_position_list)):
	# Act
	tile = grid.get_tile_at_position(position.x, position.y)

	# Assert
	assert_not_null(tile.grid_position, "Tile at position {0} not found.".format([position]))
	assert_eq(tile.grid_position, position, "Tile and grid do not agree on postion.")
	assert_is(tile, Tile, "Invalid tile type.")

func test_sprite_animations_exist(anim : String = use_parameters(expected_tile_sprites)):
	assert_not_null(tile, "sprite")
	var sprite = tile.sprite
	assert_is(sprite, AnimatedSprite2D)
	assert_not_null(sprite.sprite_frames, "Spriteframes has not been populated!")
	assert_is(sprite.sprite_frames, SpriteFrames)

	assert_has(sprite.sprite_frames.get_animation_names(), anim, "Spriteframes is missing an animation for {0}".format([anim]))

func test_tile_sprite_dimensions():
	pass

func test_tile_positioning():
	pass

func test_tiles_dont_overlap():
	pass

# When you click on a tile's area it should fire the event handler on that tile
func test_tile_knows_it_was_clicked_on():
	var click_position = tile.position + Vector2(80, 80)
	_sender.mouse_left_button_down(click_position).hold_for(.1).wait(1)
	await(_sender.idle)
	tile = grid.get_tile_at_position(0,0)
	print(tile.clicked)
	assert_true(tile.clicked, "Tile that we clicked on doesn't know about it")
	assert_false(a_different_tile.clicked)
