extends Area2D
class_name InteractiveObject

@export_category("Parameters")
@export var valueObject : int = 10
@export_enum("HP","Energy","Key","Danger") var typeObject = 0
@export_category("ExportNodes")

@export var animPlayer : AnimationPlayer


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		use_object(body)

func die()->void:
	animPlayer.play("Die")
	
func use_object(body:Player)->void:
		match typeObject:
			0:
				if body.health >= body.MAX_HEALTH:
					return
				body.addHP(valueObject)
			1:
				if body.energy >= body.MAX_ENERGY: return
				body.addEnergy(valueObject)
			2:
				if body.keys >= body.MAX_KEY: 
					return
				body.addKey(valueObject)
			3:
				body.damage(valueObject)
		die()
