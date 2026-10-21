extends Resource
class_name Order

var orderID: int
var entres: Entree
var score: int = 0

func set_entree(entree : Entree) -> void:
	entres = entree
	
func get_entree() -> Entree:
	return entres
	
func set_order_ID(id : int) -> void:
	orderID = id
	
func get_order_ID() -> int:
	return orderID
	
func set_score(_score :int) -> void:
	score = _score
	
func get_score() -> int:
	return score
