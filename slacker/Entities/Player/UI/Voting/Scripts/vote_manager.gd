extends Control
class_name VoteManager

signal closeUI
signal killPlayer
@onready var timer = $Timer
@export var PlayerIcons: Array[PlayerIcon]
@export var player:Player
var player_names : Array[String]

var canVote:bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(1, PlayerIcons.size()):
		PlayerIcons[i].buttonPressed.connect(vote_for_player)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	
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
	
func setup_nameplates(your_name:String) -> void:
	for p in get_tree().get_nodes_in_group("players"):
			player_names.push_back(p.get_player_name())
	var new_array:Array[String]
	for i in range(0,player_names.size()):
		if player_names[i]!=your_name:
			new_array.push_back(player_names[i])
	PlayerIcons[0].setPlayerNametag(your_name)
	if(new_array.size()!=0):
		for i in range(0,new_array.size()):
			if(i<=4):
				PlayerIcons[i+1].setPlayerNametag(new_array[i])
	
func close_button_pressed() -> void:
	print("Button pressed")
	closeUI.emit()
