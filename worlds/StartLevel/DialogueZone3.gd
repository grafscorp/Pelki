extends DialogueZone
@export var spirit : Ghost
@export var coll : CollisionShape2D
func action(body : Player)->void:
	spirit.set_deferred("no_player",false)
	coll.set_deferred("disabled",false)
	queue_free()
	pass
