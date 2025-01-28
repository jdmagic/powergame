extends TileMap

const waterBlockAtlasPos = Vector2i(0, 0)
const desertBlockAtlasPos = Vector2i(1, 0)
const grassBlockAtlasPos = Vector2i(2, 0)
const tundraBlockAtlasPos = Vector2i(3,0)
const mainSource = 0
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var blockType = Vector2i(-1, 0)
	for y in range(25):
		for x in range(25):
			blockType = Vector2i(-1, 0)
			var sameOrNew = rng.randi_range(1, 3)

			# Check block above
			if sameOrNew == 3 and y > 0: 
				var sameX = get_cell_atlas_coords(0, Vector2i(x, y - 1))
				if sameX != Vector2i(-1, -1):  # Check for valid coordinates
					blockType = sameX
			
			# Check block to the left
			if sameOrNew == 2 and x > 0:
				var sameY = get_cell_atlas_coords(0, Vector2i(x - 1, y))
				if sameY != Vector2i(-1, -1):  # Check for valid coordinates
					blockType = sameY
			
			# Fallback: Random block type if blockType is invalid
			if blockType.x == -1 or blockType.y < 0: 
				var newBlockType = rng.randi_range(0, 3)
				blockType = Vector2i(newBlockType, 0)
			
			# Debugging: Log the block type and position
			print("Placing block at (", x, ", ", y, ") with blockType: ", blockType)

			# Set the cell, ensure mainSource is valid
			if mainSource != null:
				set_cell(0, Vector2i(x, y), mainSource, blockType)
			else:
				print("Error: mainSource is null!")




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
