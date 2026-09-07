extends Control


func _on_join_pressed() -> void:
	Lobby.join_game(Lobby.DEFAULT_SERVER_IP)
	join_game()


func _on_host_pressed() -> void:
	Lobby.create_game()
	join_game()
	pass # Replace with function body.

func join_game():
	Lobby.player_loaded()
	Lobby.load_game("res://Scenes/test.tscn")
func _on_ip_address_text_changed(new_text: String) -> void:
	Lobby.DEFAULT_SERVER_IP = new_text
	pass # Replace with function body.


func _on_port_text_changed(new_text: String) -> void:
	Lobby.PORT = new_text
	pass # Replace with function body.
