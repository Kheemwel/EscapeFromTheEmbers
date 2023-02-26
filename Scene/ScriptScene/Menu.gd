extends Control

func _ready():
	pass # Replace with function body.

func _on_Start_pressed():
	get_tree().change_scene("res://Scene/Cabin.tscn")
	for i in range($"/root/GlobalScene".player_interface.get_child_count()):
		$"/root/GlobalScene".player_interface.get_child(i).show()

func _on_Quit_pressed():
	get_tree().quit()
	
