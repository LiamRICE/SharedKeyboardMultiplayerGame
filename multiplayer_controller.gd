extends CanvasLayer

@export var address = "127.0.0.1"
@export var port: int = 8910
@export var num_players: int = 4 # max 32
var peer: ENetMultiplayerPeer

# Called when the node enters the scene tree for the first time.
func _ready():
	# called on server and client on client connection
	multiplayer.peer_connected.connect(player_connected)
	# called on server and client on client disconnect
	multiplayer.peer_disconnected.connect(player_disconnected)
	# only called on clients
	multiplayer.connected_to_server.connect(connected_to_server)
	# only called on clients
	multiplayer.connection_failed.connect(connection_failed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func player_connected(id: int):
	print("Player connected "+str(id))


func player_disconnected(id: int):
	print("Player disconnected "+str(id))


func connected_to_server():
	print("Connected to server")
	send_player_info.rpc_id(1, $VBoxContainer/PlayerNameLineEdit.text, multiplayer.get_unique_id())


@rpc("any_peer")
func send_player_info(name: String, id: int):
	if !GameManager.players.has(id):
		GameManager.players[id] = {
			"name": name,
			"id": id,
			"score": 0
		}
	if multiplayer.is_server():
		for i in GameManager.players:
			send_player_info.rpc(GameManager.players[i].name, i)


func connection_failed():
	print("Connection failed")


func _on_host_button_button_down():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, num_players)
	if error != OK:
		print("Cannot host ", error)
		return
	# set up compression (optional)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	# set host as peer (for local host)
	multiplayer.set_multiplayer_peer(peer)
	print("Waiting for players!")
	send_player_info($VBoxContainer/PlayerNameLineEdit.text, multiplayer.get_unique_id())

func _on_join_button_button_down():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(address, port)
	# must be same compression algorithm as host
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)


func _on_start_button_button_down():
	start_game.rpc()


@rpc("any_peer", "call_local")
func start_game():
	var scene = load("res://scenes/levels/level_one_mp.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()
