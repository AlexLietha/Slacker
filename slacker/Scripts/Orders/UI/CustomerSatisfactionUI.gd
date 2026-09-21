extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	OrderManager.CompletedOrder.connect(Update)


func Update(_order : Order) -> void:
	text = "Rating: " + str(int(CustomerSatisfactionManager.GetScore()))
