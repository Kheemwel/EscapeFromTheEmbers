extends Area2D




func _on_Big_Fire_body_entered(body):
	GlobalScript._on_Fire_body_entered(body)


func _on_Big_Fire_body_exited(_body):
	GlobalScript._on_Fire_body_exited(_body)
