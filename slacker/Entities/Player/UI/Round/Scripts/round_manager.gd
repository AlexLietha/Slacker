# Aidan Musil
# State Machine that controls what phase it is during the round
# GAME LOOP
# WAITING -> PREP -> OPEN -> CLOSED
#              ^---------------'

extends Node

@onready var clock = $"../Clock"
@onready var timer = $"."
@onready var prep_sign = $"../PrepSign"
@onready var open_sign = $"../OpenSign"

var debug_print_source = "[round_manager.gd] - "

# round states
enum RoundState {
	WAITING,
	PREP,
	OPEN,
	CLOSED
}

# these values are in seconds!!!
@export var prep_time: float = 5
@export var open_time: float = 480.0
@export var closed_time: float = 15.0

var current_state: RoundState = RoundState.WAITING

func _ready():
	timer.stop()
	timer.timeout.connect(on_timer_end)
	add_to_group("RoundTimer")
	
	prep_sign.hide()
	open_sign.hide()
	
	if multiplayer.is_server():
		start_game()
	
	#print("Timer node: ", get_path())
	#print("Clock label: ", clock.get_path())
	#print("Clock instance ID: ", clock.get_instance_id())

func start_game() -> void:
	if not multiplayer.is_server():
		return
		
	if current_state != RoundState.WAITING:
		print(debug_print_source + "Game already started")
		return
		
	change_state(RoundState.PREP)
	print(debug_print_source + "Timer: game started")
	
func change_state(new_state: RoundState) -> void:
	if not multiplayer.is_server():
		return
	
	var duration: float = 0.0
	
	match new_state:
		RoundState.WAITING:
			duration = 0.0
		RoundState.PREP:
			duration = prep_time
		RoundState.OPEN:
			duration = open_time
		RoundState.CLOSED:
			duration = closed_time
			
	sync_state.rpc(new_state, duration)

# idk what @rpc does, but i based the state machine around what was done earlier:
	# @rpc("authority", "call_local", "reliable")
	# func sync_round(round_int: int, time_left: float) -> void:
		#game_started = true
		#round_num = round_int
		#timer.start(time_left)
		#print("Timer rpc called")
		#print("Timer running: ", not timer.is_stopped())
		#print("Timer remaining: ", timer.time_left)
		#print("Clock node: ", clock)
		#print("Clock visible: ", clock.is_visible_in_tree())

@rpc("authority", "call_local", "reliable")
func sync_state(new_state: RoundState, duration: float) -> void:
	exit_state(current_state)
	current_state = new_state
	enter_state(current_state, duration)
	
func enter_state(state: RoundState, duration: float) -> void:
	timer.stop()
	
	match state:
		RoundState.WAITING:
			prep_sign.hide()
			open_sign.hide()
			print(debug_print_source + "Waiting for game to start")
		
		RoundState.PREP:
			prep_sign.show()
			open_sign.hide()
			timer.start(duration)
			print(debug_print_source + "Prep round started")
			
		RoundState.OPEN:
			prep_sign.hide()
			open_sign.show()
			timer.start(duration)
			
			# during the open phase, roles are assigned and orders should start spawning
			if multiplayer.is_server():
				GameManager.assign_roles()
				OrderSpawner.start_spawning_order()
				
			print(debug_print_source + "Open round started")
			
		RoundState.CLOSED:
			prep_sign.hide()
			open_sign.hide()
			timer.start(duration)
			print(debug_print_source + "Game Over")
			
func exit_state(state: RoundState) -> void:
	match state:
		RoundState.PREP:
			print(debug_print_source + "Prep round ended")
			
		RoundState.OPEN:
			# at the end of the open phase, orders should stop spawning
			if multiplayer.is_server():
				OrderSpawner.stop_spawning_order()
			print(debug_print_source + "Open round ended")
			
func on_timer_end() -> void:
	if not multiplayer.is_server():
		return
		
	match current_state:
		RoundState.PREP:
			change_state(RoundState.OPEN) # go to open
			
		RoundState.OPEN:
			change_state(RoundState.CLOSED) # go to close
			
		RoundState.CLOSED:
			change_state(RoundState.PREP) # go back to prep

func remaining_time():
	var time_left = int(ceil(timer.time_left))
	@warning_ignore("integer_division")
	var minute = int(time_left / 60)
	var second = time_left % 60
	
	return [minute, second]

func _process(_delta):
	if current_state == RoundState.WAITING:
		return
	
	clock.text = "%02d:%02d" % remaining_time()
