extends Node

func _ready():
	#Read the commandline args to decide if server or not
	var args = Array(OS.get_cmdline_args())
	if args.has("-s"):
		print("loading server...")
		await startServer()
	else:
		print("loading client...")
		await startClient()

func startServer():
	print("Starting Server...")
	
	#Create new multiplayerpeer as server on port and assign it to multiplayer
	var server = ENetMultiplayerPeer.new()
	server.create_server(8080,32)
	multiplayer.multiplayer_peer = server
	
	multiplayer.peer_connected.connect(self._on_client_connected)
	multiplayer.peer_disconnected.connect(self._on_client_disconnected)
	

func startClient():
	print("Starting Client")
	
	#Create new multiplayerpeer as client on port and assign it to multiplayer
	var client = ENetMultiplayerPeer.new()
	client.create_client("localhost",8080)
	multiplayer.multiplayer_peer = client
	
	multiplayer.connected_to_server.connect(self._connected_to_server)
	multiplayer.server_disconnected.connect(self._disconnected_from_server)
	
func _on_client_connected(clientId):
	print("Client connected:", clientId)
	
func _on_client_disconnected(clientId):
	print("Client disconnected:", clientId)
	
func _connected_to_server():
	print("Connected to server")
	
func _disconnected_from_server():
	print("Disconnected")
