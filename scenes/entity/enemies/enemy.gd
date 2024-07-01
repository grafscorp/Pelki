extends Entity
class_name  Enemy



@export var energyRecovery : float = 1 
@export_category("Attack1")
@export var attackZone : Area2D
@export var attackZoneCollision : CollisionShape2D


@export var distanceForAttack1 : float = 1
@export var energyAttack1 : float = 30
@export_category("Attack2")
@export var energyAttack2 : float = 40

@export_category("Nodes")

@export var playerDetected : CollisionShape2D
@export var areaFollowing : CollisionShape2D
@export var rayCanMove : RayCast2D 
enum{
	DIED,
	IDLE,
	ATTACKING,
	FOLLOWING,
	DAMAGED
}
var playerTarget : Player
var enemyState = IDLE
var canMove: bool = true
var last_player_pos : Vector2 = Vector2.ZERO
var follow_to_last_pos := false
func  _ready() -> void:
	super._ready()
	playerDetected.disabled = false
	areaFollowing.disabled = true
	attackZoneCollision.disabled = true

func _process(delta: float) -> void:
	set_state()
	set_anim()

func _physics_process(delta: float) -> void:
	set_gravity(delta)
	energyUpdating(delta)
	if enemyState == FOLLOWING:
		followingToPlayer()
	elif enemyState == ATTACKING:
		pass
	elif enemyState == IDLE:
		idleAction()
		pass
	if !canMove:
		velocity.x = 0
	move_and_slide()
	pass

###PRIVATE METHODS

func energyUpdating(delta:float)->void:
	if energy>=MAX_ENERGY: return
	energy += energyRecovery*delta
	pass

func followingToPlayer()->void:
	if !playerTarget: return
	
	pass

func idleAction()->void:
	pass


func set_anim()->void:
	match enemyState:
		FOLLOWING:
			if is_on_floor():
				if velocity.x != 0:
					animPlayer.play("run")
				else:
					animPlayer.play("idle")
		IDLE:
			if is_on_floor():
				if velocity.x != 0:
					animPlayer.play("run")
				else:
					animPlayer.play("sleep")
	pass

func set_state()->void:
	if is_dead:
		enemyState = DIED
	elif is_damaged:
		enemyState = DAMAGED
	elif attacking:
		enemyState = ATTACKING
	elif playerTarget:
		enemyState = FOLLOWING
	else:
		enemyState = IDLE

###NODES MOETHODS
func _on_player_detect_body_entered(body: Node2D) -> void:
	if body is Player:
		follow_to_last_pos = false 
		playerTarget = body
		playerDetected.set_deferred("disabled", true)
		areaFollowing.set_deferred("disabled", false)
		
	pass # Replace with function body.


func _on_player_detect_body_exited(body: Node2D) -> void:
	pass # Replace with function body.

func attack1()->void:
	energy -= energyAttack1
	attacking = true
	animPlayer.play("attack1")
	pass
func attack2()->void:
	energy -= energyAttack2
	attacking = true
	animPlayer.play("attack2")
func _on_attack_zone_1_body_entered(body: Node2D) -> void:
	if body is Player:
		body.damage(DAMAGE_FORCE)
	pass # Replace with function body.

func finalAttack()->void:
	attacking = false
func die()->void:
	super.die()
	set_collision_layer_value(3,false)
	pass


func damage(Damage : int , player : Player = null)->void:
	if enemyState == IDLE:
		if player:
			playerTarget = player
		playerDetected.set_deferred("disabled",true)
		areaFollowing.set_deferred("disabled",false)
	super.damage(Damage)
	pass


func _on_player_following_body_exited(body: Node2D) -> void:
	if playerTarget:
		follow_to_last_pos = true
		last_player_pos = playerTarget.global_position
	playerTarget = null
	playerDetected.set_deferred("disabled", false)
	areaFollowing.set_deferred("disabled", true)
	pass # Replace with function body.
