extends Node

# Dear future Aidan, or future programmer,
#		Please do a state machine for the rounds instead
#		- xoxo pookie bear aidan

@onready var clock = $"../ClockUI/Clock"
@onready var round_title = $"../Round Title"
@onready var timer = $"."
@onready var prep_sign = $"../PrepSign"
@onready var open_sign = $"../OpenSign"

@export var round_name = ["Prep Time!", "Get to Work!"]
@export var round_time = [120,480]

var round_num = 0
var game_started := false

func _ready():
	timer.stop()
	add_to_group("RoundTimer")
	#if multiplayer.is_server():
		#set_next_round()

func start_game() -> void:
	if game_started:
		print("Game already started")
		return
	
	#if not multiplayer.is_server():
		#return
	game_started = true
	set_next_round()

func remaining_time():
	var time_left = timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]

#func set_round_name(name):
	#round_title.text = name

func get_round_name():
	return round_title.text
	
func set_next_round():
	#set_round_name(round_name[round_num])
	if not multiplayer.is_server():
		return
	
	timer.start(round_time[round_num])
	sync_round.rpc(round_num, round_time[round_num])
	
	if round_num == 1:
		OrderSpawner.StartSpawningOrder()
		prep_sign.hide()
		open_sign.show()
	round_num += 1

func _process(_delta):
	if not game_started:
		return
	
	clock.text = "%02d:%02d" % remaining_time()
	if multiplayer.is_server() and timer.time_left <= 0:
		timer.stop()
		#GameManager.assign_roles()
		set_next_round()

@rpc("authority", "call_local", "reliable")
func sync_round(round: int, time_left: float) -> void:
	game_started = true
	round_num = round
	timer.start(time_left)
