extends Control
class_name VoteManager

@export var PlayerIcons: Array[PlayerIcon]
@export var votedByLabels: Array[Label]
@export var player:Player
@export var notify_ui: VotePopUpUI
@onready var timer = $Timer

var canVote:bool = true
var player_names: Array[String]

signal on_voting_board_toggled(is_visible: bool)
signal voted(voter:String,voted_for:String)

var debug_print_source = "[vote_manager.gd] - "

func _ready() -> void:
	for icon in PlayerIcons:
		icon.buttonPressed.connect(vote_for_player)
	close_button_pressed()
	self.voted.connect(voted_for)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("usePhone") && !visible:
		toggle_visiblity(true)
		on_voting_board_toggled.emit(true)
	
	elif((event.is_action_pressed("usePhone") || event.is_action_pressed("controllerXboxB")) 
			&& visible):
		close_button_pressed()


func close_button_pressed() -> void:
	toggle_visiblity(false)
	on_voting_board_toggled.emit(false)


func vote_for_player(index: int,X: Array[TextureRect],VoteSlot: PlayerIcon)-> void:
	print(debug_print_source, index)
	if(canVote && index <= 2 && player != null):
		print(debug_print_source + "You are: ",player.get_player_name(),", You voted for: ",VoteSlot.get_player_nametag())
		voted.emit(player.get_player_name(), VoteSlot.get_player_nametag(),index)
		if(index == 0):
			set_faces(1,VoteSlot)
		elif(index == 2):
			set_faces(index,VoteSlot)
			
		VoteSlot.counter_setter(index+1)
		X[index].visible = true
		#print(VoteSlot.getPlayerNametag())
		#voted_by_name[counter].text = VoteSlot.getPlayerNametag()
			#killPlayer.emit()
		cool_down()
	#else:
		#print(debug_print_source + "you need to wait")


func cool_down() -> void:
	canVote = false
	await get_tree().create_timer(1).timeout
	canVote = true
	
func voted_for(voter:String,voted_for:String,index:int)->void:
	print("the voteaning has begun")
	print(player.get_player_name())
	if(voted_for == player.get_player_name()):
		print("the target has been locked down")
		#notify_ui.set_notify_face(VoteSlot.get_player_face())
		notify_ui.has_been_voted()
		PlayerIcons[0].Xs[index].visible=true
		votedByLabels[index].text = voted_for
	
func setup_nameplates(your_name:String) -> void:
	for p in get_tree().get_nodes_in_group("players"):
		print(p.get_player_name())
		player_names.push_back(p.get_player_name())
	print(player_names.size())
	
	var new_array:Array[String]
	for i in range(0,player_names.size()):
		if player_names[i]!=your_name:
			new_array.push_back(player_names[i])
	#print(debug_print_source, your_name)
	PlayerIcons[0].set_player_nametag(your_name)
	if(new_array.size()!=0):
		for i in range(0,new_array.size()):
			if(i<=4):
				PlayerIcons[i+1].set_player_nametag(new_array[i])

func set_faces(index:int,VoteSlot:PlayerIcon)->void:
	VoteSlot.set_player_face(index)
	notify_ui.set_notify_face(VoteSlot.get_player_face())

func toggle_visiblity(_is_visible: bool) -> void:
	visible = _is_visible
	if is_visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
