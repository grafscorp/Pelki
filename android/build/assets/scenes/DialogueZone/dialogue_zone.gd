extends Area2D
class_name DialogueZone

@export var Number_Dialogue : int = 0

func _on_body_entered(body: Node2D) -> void:
	if Number_Dialogue == 0: return
	if body is Player:
		body.set_dialogue(Number_Dialogue)
		await  body.dialogueMenu.DialogueCompleted
		action(body)
	pass # Replace with function body.

func action(body:Player)->void:
	queue_free()
	pass
