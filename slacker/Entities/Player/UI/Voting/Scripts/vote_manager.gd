extends Control
class_name CloseButton

signal on_voting_board_toggled(is_visible: bool)

@export var PlayerIcons: Array[PlayerIcon]

var canVote:bool = true

@onready var timer = $Timer


func _ready() -> void:
	for icon in PlayerIcons:
		icon.buttonPressed.connect(vote_for_player)
	close_button_pressed()


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


func vote_for_player(counter: int,X: Array[TextureRect],VoteSlot: PlayerIcon)-> void:
	print("Voting")
	if(canVote):
		print(counter)
		#change this to something changable
		if(counter <= 2):
			X[counter].visible = true
			VoteSlot.CounterSetter(counter+1)
		cool_down()
	else:
		print("you need to wait")


func cool_down() -> void:
	canVote = false
	await get_tree().create_timer(1).timeout
	canVote = true


func toggle_visiblity(_is_visible: bool) -> void:
	visible = _is_visible
	if is_visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
