extends Control
class_name VoteManager

signal closeUI
signal killPlayer
@onready var timer = $Timer
@export var PlayerIcons: Array[PlayerIcon]

var canVote:bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(1, PlayerIcons.size()):
		PlayerIcons[i].buttonPressed.connect(vote_for_player)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Close_Button_Pressed() -> void:
	closeUI.emit()
	
func vote_for_player(counter: int,X: Array[TextureRect],VoteSlot: PlayerIcon)-> void:
	print("Voting")
	if(canVote):
		print(counter)
		#change this to something changable
		if(counter <= 2):
			X[counter].visible = true
			VoteSlot.CounterSetter(counter+1)
			if(counter == 2):
				killPlayer.emit()
		cool_down()
	else:
		print("you need to wait")

func cool_down() -> void:
	canVote = false
	await get_tree().create_timer(1).timeout
	canVote = true
	
func setup_nameplates(Name:Array[String]) -> void:
	for i in range(0,PlayerIcons.size()):
		print("Player: ",i, " Named: ",Name[i])
		PlayerIcons[i].setPlayerNametag(Name[i])
