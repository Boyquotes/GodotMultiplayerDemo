extends Node2D

export var PORT = 3232
export var IP_ADDR = "25.3.101.236"

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	$WaitText.hide()

func _on_ButtonHost_pressed():
	var net = NetworkedMultiplayerENet.new()
	net.create_server(PORT, 2)
	get_tree().set_network_peer(net)
	print("Started hosted session at port ", PORT, " and IP ", IP_ADDR)
	$WaitText.show()

func _on_ButtonJoin_pressed():
	var net = NetworkedMultiplayerENet.new()
	print("Creating client on ", PORT, " ", IP_ADDR)
	net.create_client(IP_ADDR, PORT)
	get_tree().set_network_peer(net)

func _player_connected(id):
	Globals.player2id = id
	var game = preload("res://Game.tscn").instance()
	get_tree().get_root().add_child(game)
	hide()

func _on_IP_Address_text_changed(new_text):
	IP_ADDR = new_text

func _on_Port_text_changed(new_text):
	PORT = int(new_text)
