extends Node


var activeOrders: Array[Order] = []
var completedOrders: Array[Order] = []

signal StartedOrder(order: Order)
signal CompletedOrder(order: Order)

var orderInt := 0

func _ready() -> void:
	OrderSpawner.GetNewOrderSignal().connect(StartOrder)
	
func StartOrder(order: Order) -> Order:
	orderInt += 1
	
	order.SetOrderID(orderInt)
	activeOrders.append(order)
	
	StartedOrder.emit(order)


	return order




func GetOrder(id: int) -> Order:
	for order : Order in activeOrders:
		if order.GetOrderID() == id:
			return order
	return null

func GetActiveOrders() -> Array:
	return activeOrders

#func FindClosestOrder(plate: Plate) -> Order:
	#for order in activeOrders:
		#pass
	#pass


func CompleteOrder(plate : Plate) -> bool:
	var plateEntree = plate.GetItem()
	
	for order : Order in activeOrders:
		if order.GetEntree().GetName() == plateEntree.GetName():
			if plateEntree.cooked:
				order.SetScore(100)
			print("Completed Order")
			CompletedOrder.emit(order)
			
			activeOrders.erase(order)
			completedOrders.append(order)
			return true
	return false
	
