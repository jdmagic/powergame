class_name Player extends Node2D

var powerLevel
var money
var playerGenerators: Array[Generator]
var totalDelta
var controlNode

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	powerLevel = 0
	money = 0
	totalDelta = 0
	
func _ready() -> void:
	controlNode = get_node("Control")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	controlNode.updateMoney(money)
	controlNode.updatePower(powerLevel)
	if (totalDelta < 1):
		totalDelta += delta
	else:
		totalDelta = 0
		updatePower()
		powerToMoney()
		
func addGenerator(g: Generator) -> void:
	playerGenerators.append(g)	

func updatePower():
	for g in playerGenerators:
		powerLevel += g.getPowerTick()
		
func powerToMoney():
	pass
			
