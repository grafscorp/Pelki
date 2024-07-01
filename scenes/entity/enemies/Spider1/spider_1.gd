extends Enemy
class_name Spider1


var start_position : Node2D
var direction : int = 0
var can_attack : bool = false

@export var DAMAGE_FORCE2 : int = 20
func _ready() -> void:
	super._ready()
	start_position = get_parent()
	start_position.global_position = self.global_position
func _process(delta: float) -> void:
	super._process(delta)
func _physics_process(delta: float) -> void:
	canMove = $RayCast2D.is_colliding()
	super._physics_process(delta)
func idleAction()->void:
	if follow_to_last_pos:
		if positive_pos(global_position.x - last_player_pos.x)<200:
			velocity.x = 0
			follow_to_last_pos = false
		else:
			lookAtVector(last_player_pos)
			velocity.x = direction * -MAX_SPEED
	else:
		if global_position.distance_to(start_position.global_position)<105:
			velocity.x = 0
		else:
			lookAtTarget(start_position)
			velocity.x = direction * -MAX_SPEED
func followingToPlayer()->void:
	if !playerTarget: return
	if !can_attack:
		lookAtTarget(playerTarget)
		#if global_position.distance_to(playerTarget.global_position) < 488:
		if positive_pos(global_position.x - playerTarget.global_position.x) < 488:
			velocity.x = direction * MAX_SPEED
		elif positive_pos(global_position.x - playerTarget.global_position.x) > 1200:
			velocity.x = direction * -MAX_SPEED
		else:
			velocity.x = 0
	else:
		if !attacking:
			if global_position.distance_to(playerTarget.global_position)< distanceForAttack1 and energy >= energyAttack2:
				attack2()
			elif energy >= energyAttack1:
				attack1()
		velocity.x = 0

func lookAtTarget(target : Node2D)->void:
	if global_position.x < target.global_position.x:
		direction = -1
		scale.x = direction * scale.y
	else:
		direction = 1
		scale.x = scale.y
func lookAtVector(target: Vector2)->void:
	if global_position.x < target.x:
		direction = -1
		scale.x = direction * scale.y
	else:
		direction = 1
		scale.x = scale.y
	pass
func positive_pos(value:float)->float:
	if value >=0:
		return value
	else:
		return -value

		
func _on_player_in_attack_zone_body_entered(body: Node2D) -> void:
	can_attack = true
	pass # Replace with function body.

func _on_player_in_attack_zone_body_exited(body: Node2D) -> void:
	can_attack = false
	pass # Replace with function body.


func _on_attack_zone_2_body_entered(body: Node2D) -> void:
	if body is Player:
		body.damage(DAMAGE_FORCE2)
	pass # Replace with function body.
func finalAttack()->void:
	super.finalAttack()
	$SpineSprite/SpineBoneNode/AttackZone2/CollisionShape2D.set_deferred("disabled", true)
	$AttackZone1/CollisionShape2D.set_deferred("disabled", true)
