extends Resource
class_name PlayerRole

enum Type {
	NONE,
	SLACKER,
	COOK,
	RAT
}

@export var type: Type = Type.NONE
@export var display_name: String = ""
