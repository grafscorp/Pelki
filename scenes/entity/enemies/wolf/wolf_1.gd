extends Enemy
class_name  Wolf1



func _ready() -> void:
	super._ready()
	
func _process(delta: float) -> void:
	super._process(delta)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	pass
func followingToPlayer()->void:
	super.followingToPlayer()
	if !playerTarget: return
	if global_position.x - (playerTarget.global_position.x) < distanceForAttack1 and global_position.distance_to(playerTarget.global_position) > 520 :
		attack1()
		pass
	pass
