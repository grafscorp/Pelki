extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.hud.seepBTN.visible = true
		body.hud.EBar.visible = true
	queue_free()
	pass # Replace with function body.
