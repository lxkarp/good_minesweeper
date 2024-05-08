extends Node2D
class_name Grid

var TileScene = preload("res://Tile.tscn")

var size  : int = 4
var tiles : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func populate_tiles():
	if size <= 0:
		return
	# Initialize the grid
	tiles = []

	# Create rows
	for y in range(size):
		var row = []
		# Create tiles in each row
		for x in range(size):
			var tile = TileScene.instantiate()
			tile.grid_position = Vector2(x, y)
			add_child(tile)
			row.append(tile)
		tiles.append(row)

func get_tiles() -> Array:
	var all_tiles = []
	for row in tiles:
		all_tiles += row
	return all_tiles

func get_tile_at_position(x: int, y: int) -> Tile:
	return tiles[y][x]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

