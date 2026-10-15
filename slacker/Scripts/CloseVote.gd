extends Control
class_name CloseButton
signal closeUI
@onready var timer = $Timer
@export var PlayerIcons: Array[PlayerIcon]


var canVote:bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for icon in PlayerIcons:
		icon.buttonPressed.connect(VoteForPlayer)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Close_Button_Pressed() -> void:
	closeUI.emit()
	
func VoteForPlayer(counter: int,X: Array[TextureRect],VoteSlot: PlayerIcon)-> void:
	print("Voting")
	if(canVote):
		print(counter)
		#change this to something changable
		if(counter <= 2):
			X[counter].visible = true
			VoteSlot.CounterSetter(counter+1)
		coolDown()
	else:
		print("you need to wait")

func coolDown() -> void:
	canVote = false
	await get_tree().create_timer(1).timeout
	canVote = true
