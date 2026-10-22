extends VBoxContainer
class_name OrderList

#signal makeTicket

func _ready() -> void:
	OrderManager.StartedOrder.connect(add_order)
	OrderManager.CompletedOrder.connect(delete_order)

func add_order(order: Order) -> void:
	var _label: String
	var _board = Order_Board.new()
	_label = "ORDER \n---------\n" + order.get_entree().get_name() + "\n---------"

func update_order(order: Order) -> void:
	print("Updating Order UI")
	for child in get_children():
		if child is not OrderElement:
			return
		
		if child.order == order:
			child.text = "ORDER \n------\n" + order.get_current_step().description + "------"
	pass

func delete_order(order: Order) -> void:
	for child in get_children():
		if child is not OrderElement:
			return
		
		if child.order == order:
			remove_child(child)
		
