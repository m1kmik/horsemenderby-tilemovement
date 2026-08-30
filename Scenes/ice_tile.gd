@tool
extends Area2D


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.is_ice = true


func _on_body_exited(body):
	if body.is_in_group("player"):
		body.iceDirection = Vector2.ZERO
		body.is_ice = false
		
