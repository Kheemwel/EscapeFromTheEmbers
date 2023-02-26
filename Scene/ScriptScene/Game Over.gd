extends Control


func _on_Quit_pressed():
	get_tree().quit();


func _on_StartAgain_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scene/Cabin.tscn");
