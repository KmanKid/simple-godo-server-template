extends Control
@export var messages = ""
	
func _process(delta):
	if multiplayer.is_server():
		$Role.text = "Server" 
	else: 
		$Role.text = "Client"
	$Messages.text = self.messages

@rpc("any_peer")
func sendMessage(clientId, message):
	#Prevent the server to send messages 
	if multiplayer.is_server():
		messages += str(clientId)  + ": " + message


func _on_input_text_changed():
	#Check for return character, send the message and then reset the input
	if $Input.text[$Input.text.length()-1] == "\n":
		rpc("sendMessage",multiplayer.get_unique_id(),$Input.text)
		$Input.text = ""
