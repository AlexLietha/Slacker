extends Node
class_name SatisfactionManager

var score : float = 75
var ordersCompleted : int = 1

func _ready() -> void:
	OrderManager.CompletedOrder.connect(update_score)
	
	
func update_score(order : Order) -> void:
		ordersCompleted += 1
		score += order.get_score()
		
func get_score() -> float:
	return score / ordersCompleted
