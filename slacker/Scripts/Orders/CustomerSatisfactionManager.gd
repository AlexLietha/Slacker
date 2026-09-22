extends Node
class_name SatisfactionManager

var score : float = 375
var ordersCompleted : int = 5

func _ready() -> void:
	OrderManager.CompletedOrder.connect(UpdateScore)
	
	
func UpdateScore(order : Order) -> void:
		ordersCompleted += 1
		score += order.GetScore()
		
func GetScore() -> float:
	return score / ordersCompleted
