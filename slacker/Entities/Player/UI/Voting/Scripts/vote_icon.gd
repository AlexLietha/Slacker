extends TextureButton
class_name PlayerIcon

@export var Xs: Array[TextureRect]
@export var NamePlate: Label
@export var faces: Array[CompressedTexture2D]

var counter: int = 0
var playerName:String

signal buttonPressed(counter: int,Xs:Array[TextureRect],PlayerIcon)

var debug_print_source = "[vote_icon.gd] - "

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_pressed() -> void:
	print(debug_print_source + "Vote Button Pressed")
	#var id = get_instance_id()
	print(debug_print_source + "emit")
	buttonPressed.emit(counter,Xs,self)
	print(debug_print_source + "emitted")
	
func counter_setter(newCounter: int)->void :
	counter = newCounter
	
func get_player_nametag()-> String:
	return NamePlate.text
	
func set_player_nametag(name: String)-> void:
	NamePlate.text = name

func get_player_face()->CompressedTexture2D:
	return self.texture_normal
	
func set_player_face(index:int)-> void:
	if(index <= faces.size()):
		self.texture_normal = faces[index]
	else:
		print(debug_print_source + "Index to large for faces array")
	
