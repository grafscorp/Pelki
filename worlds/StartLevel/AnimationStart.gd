extends AnimationPlayer
@export var player : Player

func _ready() -> void:
	player.set_deferred("can_input",false)
	
func start()->void:
	player.set_deferred("can_input",false)
func end()->void:
	player.set_deferred("can_input",true)
