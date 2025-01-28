class_name Player extends Node2D

var powerLevel
var money
var playerGenerators: Array[Generator]

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	powerLevel = 0
	money = 0
	
func addGenerator(g: Generator) -> void:
	playerGenerators.append(g)	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	updatePower()
	powerToMoney()

func updatePower():
	for g in playerGenerators:
		powerLevel += g.getPowerTick()
