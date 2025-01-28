extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func updateMoney(money: int):
	get_node("Money").text = "Money: " + str(money)
	
func updatePower(power: int):
	get_node("Power").text = "Power: " + str(power)	
