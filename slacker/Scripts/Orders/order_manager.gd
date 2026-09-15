extends Node


var activeOrders: Dictionary = {}
var completedOrders: Dictionary = {}

signal StartedOrder(order: Order)
signal CompletedOrder(order: Order)

var orderInt := 0

func _ready() -> void:
	OrderSpawner.GetNewOrderSignal().connect(StartOrder)
	#OrderSpawner.StartSpawningOrder()
	
func StartOrder(order: Order) -> Order:
	orderInt += 1
	var newOrder: Order = order.duplicate(true)
	
	newOrder.orderID = orderInt
	activeOrders[newOrder.orderID] = newOrder
	
	StartedOrder.emit(order)
	print("Started order: ", order.title)


	return order




func GetOrder(instance_id: String) -> Order:
	return activeOrders.get(instance_id)


func GetActiveOrders() -> Array:
	return activeOrders.values()

#func FindClosestOrder(plate: Plate) -> Order:
	#for order in activeOrders:
		#pass
	#pass


func CompleteOrder(order: Order) -> void:
	activeOrders.erase(order.instance_id)

	completedOrders[order.instance_id] = order
	
	CompletedOrder.emit(order)
	print("Order completed: ", order.title)
