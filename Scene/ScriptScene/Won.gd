extends Control

func _on_StartAgain_pressed():
	get_tree().change_scene("res://Scene/Cabin.tscn");


func _on_Quit_pressed():
	get_tree().quit();
