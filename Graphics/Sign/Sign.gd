extends Area2D

func _input(event):
	if event.is_action_pressed("game_interaction") and len(get_overlapping_bodies()) > 0:
		FindDialogues();
	
func FindDialogues():
	var DialogPlayer = get_node_or_null("DialoguePlayer")
	
	if DialogPlayer:
		DialogPlayer.play()
		
