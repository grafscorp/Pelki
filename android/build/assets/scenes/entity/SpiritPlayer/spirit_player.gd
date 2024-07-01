extends CharacterBody2D
class_name Ghost

@export var player : Player 
@export var MAX_SPEED : float = 500
@export var animPlayer : AnimationPlayer 
var no_player : bool = false
enum {
	NOPLAYER,
	IDLE,
	FOLLOWING
}
var ghost_state = IDLE
func _ready() -> void:
	no_player = true
	animPlayer.play("idle")
	pass
func _physics_process(delta: float) -> void:
	set_states()
	match ghost_state:
		FOLLOWING:
			following(delta)
		IDLE:
			velocity = Vector2.ZERO

			pass
	pass
func set_states()->void:
	if no_player:
		ghost_state = NOPLAYER
	elif self.global_position.distance_to(player.ghostMarker.global_position) > 50:
		ghost_state = FOLLOWING
	else:
		ghost_state = IDLE
	pass

func following(delta : float):
	#velocity = Vector2.ZERO
	var direction = (player.ghostMarker.global_position - self.global_position).normalized()
	velocity +=  direction * MAX_SPEED * delta
	velocity.x = clamp(velocity.x,-MAX_SPEED,MAX_SPEED)
	move_and_slide()
	pass
