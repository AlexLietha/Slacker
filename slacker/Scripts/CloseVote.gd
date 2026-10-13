extends Control
class_name CloseButton
signal closeUI
@onready var timer = $Timer
@onready var Vote1: PlayerIcon = $PlayerIcon2
@onready var Vote2: PlayerIcon = $PlayerIcon3
@onready var Vote3: PlayerIcon = $PlayerIcon4
@onready var Vote4: PlayerIcon = $PlayerIcon5

var canVote:bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Vote1.buttonPressed.connect(VoteForPlayer.bind(Vote1))
	Vote2.buttonPressed.connect(VoteForPlayer.bind(Vote2))
	Vote3.buttonPressed.connect(VoteForPlayer.bind(Vote3))
	Vote4.buttonPressed.connect(VoteForPlayer.bind(Vote4))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Close_Button_Pressed() -> void:
	closeUI.emit()
	
func VoteForPlayer(id: String,counter: int,X: Array[TextureRect],VoteSlot: PlayerIcon)-> void:
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
