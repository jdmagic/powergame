class_name Generator extends Node2D


# Called when the node enters the scene tree for the first time.
func _init(owner: Player) -> void:
	owner.addGenerator(self)	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(owner)
	
	
func getPowerTick() -> int:
	return 0
