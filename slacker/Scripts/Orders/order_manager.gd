extends Node


var activeOrders: Dictionary = {}
var completedOrders: Dictionary = {}

signal StartedOrder(order: Order)
signal CompletedOrder(order: Order)

var orderInt := 0

func _ready() -> void:
	OrderSpawner.GetNewOrderSignal().connect(StartOrder)

func StartOrder(order: Order) -> Order:
	orderInt += 1
	var newOrder: Order = order.duplicate(true)
	
	newOrder.orderID = orderInt
	activeOrders[newOrder.orderID] = newOrder
	
	StartedOrder.emit(order)
	print("Started order: ", order.title)
	print("Instance ID: ", order.instance_id)
	#print("active orders:", active_orders)

	return order




func GetOrder(instance_id: String) -> Order:
	return activeOrders.get(instance_id)


func GetActiveOrders() -> Array:
	return activeOrders.values()


func ReportEvent(event_type: String, target_id: String, amount: int = 1) -> void:

	for order in activeOrders.values():
		var step: TaskStep = order.get_current_step()

		if step == null:
			continue

		if step.matches_event(event_type, target_id):
			step.progress(amount)
			
			print(
				order.title,
				": ",
				step.description,
				" ",
				step.current_amount,
				"/",
				step.required_amount
			)

			order.check_progress()
			
			if order.completed:
				CompleteOrder(order)
				CompletedOrder.emit(order)

		return


func CompleteOrder(order: Order) -> void:
	activeOrders.erase(order.instance_id)

	completedOrders[order.instance_id] = order
	
	CompletedOrder.emit(order)
	print("Order completed: ", order.title)
