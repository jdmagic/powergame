class_name RiverGenerator extends Generator


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _init(owner: Player):
	super(owner)	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func getPowerTick() -> int:
	return 5
