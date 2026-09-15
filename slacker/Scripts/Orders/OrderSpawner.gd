extends Node

	
var timeTilNextOrder = 10.0
#var listOfEntres : Array[Order] = [preload("res://Orders & Tasks/Orders/Burger.tres")]
var canSpawnNextOrder = true
signal NewOrder(order: Order)
var rng = RandomNumberGenerator.new()


func CreateOrder():
	#var newOrder = listOfEntres.pick_random()
	#NewOrder.emit(newOrder)
	
	#OrderManager.start_order(new_order)
	pass
func GetNewOrderSignal() -> Signal:
	return NewOrder
	
func SpawnOrders():
	await get_tree().create_timer(timeTilNextOrder).timeout
	timeTilNextOrder = rng.randf_range(7.5, 20.0)
	
	if canSpawnNextOrder:
		CreateOrder()
		SpawnOrders()
		
func StopSpawningOrder():
	canSpawnNextOrder = false
	
func StartSpawningOrder():
	canSpawnNextOrder = true
	SpawnOrders()
		
		
