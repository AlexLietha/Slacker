extends TextureButton
class_name PlayerIcon

@export var Xs: Array[TextureRect]
@export var NamePlate: Label
@export var faces: Array[CompressedTexture2D]

var counter: int = 0
var playerName:String

signal buttonPressed(counter: int,Xs:Array[TextureRect],PlayerIcon)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_pressed() -> void:
	print("Vote Button Pressed")
	#var id = get_instance_id()
	print("emit")
	buttonPressed.emit(counter,Xs,self)
	print("emitted")
	
func CounterSetter(newCounter: int)->void :
	counter = newCounter
	
func getPlayerNametag()-> String:
	return NamePlate.text
	
func setPlayerNametag(name: String)-> void:
	NamePlate.text = name

func get_player_face()->CompressedTexture2D:
	return self.texture_normal
	
func setPlayerFace(index:int)-> void:
	if(index <= faces.size()):
		self.texture_normal = faces[index]
	else:
		print("Index to large for faces array")
	
