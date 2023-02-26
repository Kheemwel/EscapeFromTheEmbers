extends Area2D

func _on_Transition_Gate_Small_body_entered(_body):
	GlobalScene.from_level = get_parent().name 
	get_tree().change_scene("res://Scene/" + self.name + ".tscn")
