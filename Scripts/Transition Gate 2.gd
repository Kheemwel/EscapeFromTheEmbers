extends Area2D

func _on_Transition_Gate_Big_body_entered(_body):
	GlobalScene.from_level = get_parent().name 
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scene/" + self.name + ".tscn")
	if self.name == "Won":
		$"/root/GlobalScript".damagetimer.stop()
		$"/root/GlobalScript".burntimer.stop()
		$"/root/GlobalScript".is_player_burning = false
		$"/root/GlobalScript".is_player_burned = false
		$"/root/GlobalScene".healthbar.hide()
		$"/root/GlobalScene".healthbar.value = 100
		$"/root/GlobalScene".debuff.hide()
		$"/root/GlobalScene".player_health = 100
