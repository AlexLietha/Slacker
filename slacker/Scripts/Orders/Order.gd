extends Resource
class_name Order


var orderID: int
var entres: Entree

func SetEntree(entree : Entree) -> void:
	entres = entree
	
func GetEntree() -> Entree:
	return entres
	
func SetOrderID(id : int) -> void:
	orderID = id
	
func GetOrderID() -> int:
	return orderID
	
