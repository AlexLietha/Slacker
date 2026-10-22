extends CanvasLayer

const STEAM_APP_ID: int = 480
const MAX_PLAYERS: int = 6
const JOIN_CODE_LENGTH: int = 4
const WORLD = preload("res://Utilities/Multiplayer/Scenes/FunctionalKitchen_multi.tscn")
const PLAYER = preload("res://Entities/Player/Scenes/player.tscn")

@onready var button_create: Button = %ButtonCreate
@onready var button_join: Button = %ButtonJoin
@onready var button_quit: Button = %ButtonQuit
@onready var text_lobby_id: LineEdit = %TextLobbyID

var args : PackedStringArray
var join_code: String = ""
var is_joining: bool = false

var peer: SteamMultiplayerPeer = SteamMultiplayerPeer.new()

func _ready() -> void:
	button_create.pressed.connect(on_create)
	button_join.pressed.connect(on_join_pressed)
	button_quit.pressed.connect(func(): get_tree().quit())
	args = OS.get_cmdline_args()
	
	if not Steam.lobby_created.is_connected(on_lobby_created):
		Steam.lobby_created.connect(on_lobby_created)
	
	if not Steam.lobby_match_list.is_connected(check_lobby_code):
		Steam.lobby_match_list.connect(check_lobby_code)
	
	if not Steam.lobby_joined.is_connected(on_join_lobby):
		Steam.lobby_joined.connect(on_join_lobby)
	
	var steam_initiated = Steam.steamInit(
		STEAM_APP_ID,
		true
	)
	
	if steam_initiated:
		print("Steam initiated")
	else:
		print("Steam failed to initalize")
	
	#if OS.has_feature('server'):
		#Network.start_server()
		#add_world()
		#hide()

func _process(delta: float) -> void:
	Steam.run_callbacks()

# ----------------------
# HOSTING
# ----------------------

func on_create() -> void:
	print("Creating lobby...")
	
	Steam.createLobby(
		Steam.LOBBY_TYPE_PUBLIC,
		MAX_PLAYERS
	)
	
	$".".hide()
	#$"../TimerUI".show()
	if multiplayer.is_server():
		$"../StartMenu".show()
	
	#Network.start_server()
	#add_world()
	#await get_tree().process_frame
	#hide()

func on_lobby_created(result: int, lobby_id: int) -> void:
	if result != 1:
		push_error("Failed to create steam lobby")
		return
	
	#Create 4 digit join code
	join_code = str(randi_range(0, 9999)).pad_zeros(JOIN_CODE_LENGTH)
	
	var data_set: bool = Steam.setLobbyData(
		lobby_id,
		"join_code",
		join_code
	)
	
	#create host multi peer
	peer = SteamMultiplayerPeer.new()
	peer.server_relay = true
	
	var host_error = peer.create_host()
	if host_error != OK:
		push_error("Failed to create host: %s" % host_error)
		return
	
	multiplayer.multiplayer_peer = peer
	
	print("Host peer created successfully with id: ", multiplayer.get_unique_id())
	print("Is server: ", multiplayer.is_server())
	
	##Need to uncomment after implementing player spawner
	$"../MultiplayerSpawner".spawn_host()
	print("Lobby created successfully")
	print("Lobby ID: ", lobby_id)
	print("Join code: ", join_code)

# ----------------------
# JOINGING
# ----------------------

func on_join_pressed() -> void:	
	#if not Network.if_server_open:
		#print("No game instance joinable")
		#return
	
	#if not Network.if_server_open:
		#Network.start_server()
		#add_world()
		#await get_tree().process_frame
		#print("Host joined")
	#else:
		#add_world()
		#await get_tree().process_frame
		#Network.join_server()
		#print("Menu: joined")
	
	join_code = text_lobby_id.text.strip_edges()
	
	if not join_code.is_valid_int() or join_code.length() != JOIN_CODE_LENGTH:
		push_error("Enter a valid 4 digit code")
		return
	
	print("Searching for lobby with code: ", join_code)
	
	is_joining = true
	print("Joining set true -> On_join_pressed()")
	Steam.requestLobbyList()
	
	$".".hide()
	#$"../TimerUI".show()
	
	#add_world()
	#Network.join_server()
	#hide()
	#print("Menu: joined")

func check_lobby_code(lobbies: Array) -> void:
	for lobby_id in lobbies:
		var code: String = Steam.getLobbyData(
			lobby_id,
			"join_code"
		)
		
		if code.is_empty():
			continue
		
		if code == join_code:
			print("Found lobby: ", lobby_id)
			Steam.joinLobby(lobby_id)
			return
		
		print("Lobby found with: ", code)
	
	is_joining = false
	print("Joining set false -> check_lobby_code()")
	push_warning("No lobby found with that join code.")

# ----------------------
# CONNECTING
# ----------------------

func add_world() -> void:
	if get_tree().current_scene.has_node("FunctionalKitchen_multi"):
		return
	
	var new_world = WORLD.instantiate()
	new_world.name = "FunctionalKitchen_multi"
	get_tree().current_scene.add_child.call_deferred(new_world)
	print("World added")

func on_join_lobby(
	lobby_id: int,
	_permissions: int,
	_locked: bool,
	response: int
) -> void:
	if not is_joining:
		print("Menu: player is not joining")
		return
	
	if response != 1:
		is_joining = false
		push_error("Failed to enter Steam lobby. Response: %s" % response)
		print("Failed to enter steam lobby")
		return
	
	# Find the lobby owner's Steam ID.
	var host_id: int = Steam.getLobbyOwner(lobby_id)
	
	# Create the client's multiplayer peer.
	peer = SteamMultiplayerPeer.new()
	peer.server_relay = true
	
	print("Creating Steam multiplayer client for host: ", host_id)
	
	var error = peer.create_client(host_id, 0)
	
	if error != OK:
		push_error("Failed to create Steam client: %s" % error)
		is_joining = false
		print("Joinging set false -> join_lobby fail to create client")
		return
	
	multiplayer.multiplayer_peer = peer
	
	print("Client peer assigned.")
	print("Unique peer ID: ", multiplayer.get_unique_id())
	print("Is server: ", multiplayer.is_server())
	
	is_joining = false
	print("Joinging set false -> join_lobby joined lobby")
	
	print("Joined lobby: ", lobby_id)
	print("Connecting to lobby owner: ", host_id)
	print("Waiting for the host to spawn this player's character.")
