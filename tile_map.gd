extends TileMap

const waterBlockAtlasPos = Vector2i(0, 0)
const desertBlockAtlasPos = Vector2i(1, 0)
const grassBlockAtlasPos = Vector2i(2, 0)
const tundraBlockAtlasPos = Vector2i(3,0)
const mainSource = 0
const boardSize = 25
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initalizeTerrain()
	initialSmoothingPass()
	

# this function handles the initial creation of a world. 
func initalizeTerrain() -> void:
	var blockType = Vector2i(-1, 0)
	for y in range(boardSize):
		for x in range(boardSize):
			blockType = Vector2i(-1, 0)
			var sameOrNew = rng.randi_range(1, 5)

			var validX = false
			var validY = false
			
			if sameOrNew > 1: # use a block that matches a nearby one 
				var sameX = Vector2i(-1, 0)
				var sameY = Vector2i(-1, 0)
				

				# check block above	
				if y > 0: 
					sameX = get_cell_atlas_coords(0, Vector2i(x, y - 1))
					validX = true
				# check block to the left
				if x > 0:
					sameY = get_cell_atlas_coords(0, Vector2i(x - 1, y))
					validY = true

				# if both blocks are valid, use a random one
				# if only one is valid, use that one
				if validX && validY:
					var aboveOrSide = rng.randi_range(1, 2)
					if aboveOrSide == 1: blockType = sameX
					else: blockType = sameY
				else: if validX:
					blockType = sameX
				else: if validY:
					blockType = sameY
			
			# random block type if that's what was randomly chosen,
			# or if there was no valid neighbor block to copy from.
			if sameOrNew == 1 || (!validX && !validY): 
				blockType = selectRandomBlock()
			
			# Debugging: Log the block type and position
			print("Placing block at (", x, ", ", y, ") with blockType: ", blockType)

			# Set the cell, ensure mainSource is valid
			if mainSource != null:
				set_cell(0, Vector2i(x, y), mainSource, blockType)
			else:
				print("Error: mainSource is null!")

# this function is used to generate random blocks when needed. 
# "biome distribution" should be fully controlled by this function.
# therefore, use this when possible elsewhere, 
# and edit this to edit biome distribution.
func selectRandomBlock() -> Vector2i:
	var randomnum = rng.randi_range(1,3)
	return Vector2i(randomnum, 0)

# if any given tile has no direct neighbors using the same texture, then 
# replace that tile with the texture of one of its neighbors. 
func initialSmoothingPass() -> void:
	for y in range(boardSize):
		for x in range(boardSize):
			var current_texture = get_cell_atlas_coords(0, Vector2i(x, y))
			var possible_replacements: Array[Vector2i] = []
			var needs_smoothing = true

			# check neighbors one by one; exit early if a match is found
			if x > 0 and get_cell_atlas_coords(0, Vector2i(x - 1, y)) == current_texture:
				needs_smoothing = false
			elif y > 0 and get_cell_atlas_coords(0, Vector2i(x, y - 1)) == current_texture:
				needs_smoothing = false
			elif x < boardSize - 1 and get_cell_atlas_coords(0, Vector2i(x + 1, y)) == current_texture:
				needs_smoothing = false
			elif y < boardSize - 1 and get_cell_atlas_coords(0, Vector2i(x, y + 1)) == current_texture:
				needs_smoothing = false

			# only collect neighbors and smooth if no neighbors matched
			if needs_smoothing:
				if x > 0:
					possible_replacements.append(get_cell_atlas_coords(0, Vector2i(x - 1, y)))
				if y > 0:
					possible_replacements.append(get_cell_atlas_coords(0, Vector2i(x, y - 1)))
				if x < boardSize - 1:
					possible_replacements.append(get_cell_atlas_coords(0, Vector2i(x + 1, y)))
				if y < boardSize - 1:
					possible_replacements.append(get_cell_atlas_coords(0, Vector2i(x, y + 1)))

				# replace the tile with a random texture from its neighbors
				if possible_replacements.size() > 0:
					var new_texture = possible_replacements[rng.randi_range(0, possible_replacements.size() - 1)]
					set_cell(0, Vector2i(x, y), mainSource, new_texture)
					print("Smoothed block at (", x, ",", y, ")")





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
