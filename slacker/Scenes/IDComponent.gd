extends Node
class_name IDComponent

# ID for quests
@export var item_quest_id : String


func GetID() -> String:
	return item_quest_id

func ChangeQuestID(new_id : String):
	item_quest_id = new_id
