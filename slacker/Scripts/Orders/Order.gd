extends Resource
class_name Order


var orderID: int
var entres: Entree
var score: int = 0

func SetEntree(entree : Entree) -> void:
	entres = entree
	
func GetEntree() -> Entree:
	return entres
	
func SetOrderID(id : int) -> void:
	orderID = id
	
func GetOrderID() -> int:
	return orderID
	
func SetScore(_score :int) -> void:
	score = _score
	
func GetScore() -> int:
	return score
