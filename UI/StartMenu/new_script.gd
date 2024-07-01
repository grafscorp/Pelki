extends Sprite2D
@export var speed : float = 1

func _physics_process(delta: float) -> void:
	rotation_degrees += speed * 0.5 
