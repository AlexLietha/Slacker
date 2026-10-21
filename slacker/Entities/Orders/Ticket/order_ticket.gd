extends Area3D
class_name OrderTicket

@export var label3d: Label3D
var order: Order

var debug_print_source = "[order_ticket.gd] - "

func _ready() -> void:
	set_text("Hello World")
	position = Vector3(1,10,1)
	print(debug_print_source, position)
	
func set_text(newText: String) -> void:
	if label3d:
		label3d.text = newText
		
func set_order(orderName: Order) -> void:
	order = orderName
	
func move_ticket(pos: Vector3)-> void:
	position = pos
