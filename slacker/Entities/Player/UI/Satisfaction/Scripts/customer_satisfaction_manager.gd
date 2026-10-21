extends Node
class_name SatisfactionManager

var score : float = 0
var ordersCompleted : int = 0

func _ready() -> void:
	OrderManager.CompletedOrder.connect(UpdateScore)
	
	
func UpdateScore(order : Order) -> void:
		ordersCompleted += 1
		score += order.get_score()
		
func GetScore() -> float:
	if ordersCompleted != 0: # divide by 0 error
		return score / ordersCompleted
	return 75 # yeah. probably change this later
