extends Node

var timeTilNextOrder = 10.0
var listOfEntres : Array[Entree] = [preload("uid://djbrti3q0enq"), preload("uid://du8ppeqhq88dr")]
var canSpawnNextOrder = true
signal NewOrder(order: Order)
var rng = RandomNumberGenerator.new()


func CreateOrder():
	var newOrder = listOfEntres.pick_random()
	NewOrder.emit(newOrder)
	
	OrderManager.start_order(newOrder)
	pass

func GetNewOrderSignal() -> Signal:
	return NewOrder
	
func SpawnOrders():
	await get_tree().create_timer(timeTilNextOrder).timeout
	timeTilNextOrder = rng.randf_range(1, 1.1)
	
	if canSpawnNextOrder:
		CreateOrder()
		SpawnOrders()
		
func StopSpawningOrder():
	canSpawnNextOrder = false
	
func StartSpawningOrder():
	canSpawnNextOrder = true
	SpawnOrders()
