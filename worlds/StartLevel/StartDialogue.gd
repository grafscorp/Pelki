extends DialogueZone
func action(player: Player)->void:
	player.hud.visible = true
	queue_free()
