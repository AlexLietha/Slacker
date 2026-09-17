extends Node

	
var timeTilNextOrder = 1.0
var listOfEntres : Array[Entree] = [preload("res://Orders & Tasks/Orders/Burger.tres")]
var canSpawnNextOrder = true
signal NewOrder(order: Order)
var rng = RandomNumberGenerator.new()


func CreateOrder():
	print("Creating New Order")
	var newOrder = Order.new()
	
	newOrder.SetEntree(listOfEntres.pick_random())
	print("New Order Wants " + newOrder.GetEntree().GetName())

	NewOrder.emit(newOrder)
	
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
