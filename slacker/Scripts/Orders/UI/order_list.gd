extends VBoxContainer
class_name OrderList

#signal makeTicket

func _ready() -> void:
	OrderManager.StartedOrder.connect(AddOrder)
	OrderManager.CompletedOrder.connect(DeleteOrder)

func AddOrder(order: Order) -> void:
	var label: String
	var board = Order_Board.new()
	label = "ORDER \n---------\n" + order.GetEntree().GetName() + "\n---------"

func UpdateOrder(order: Order) -> void:
	print("Updating Order UI")
	for child in get_children():
		if child is not OrderElement:
			return
		
		if child.order == order:
			child.text = "ORDER \n------\n" + order.get_current_step().description + "------"
	pass

func DeleteOrder(order: Order) -> void:
	for child in get_children():
		if child is not OrderElement:
			return
		
		if child.order == order:
			remove_child(child)
		
