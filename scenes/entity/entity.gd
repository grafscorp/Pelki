extends CharacterBody2D
class_name  Entity

@export_range(0,10000,1) var MAX_HEALTH : int = 100
@export var MAX_SPEED : float = 100
@export_range(0,1000,1) var MAX_ENERGY : float =100
@export var DAMAGE_FORCE : int = 1
@export_range(0,1,0.1) var friction_x : float  =1 

@export var TimeToJumpPeak : float = 0.5
@export var JumpHeight : int = 500
var JumpForce
var GRAVITY : float
@export_category("Nodes")
@export var animPlayer : AnimationPlayer

var speed  : float
var health : int
var energy : float
var in_water: bool = false
var attacking : bool = false
var is_damaged : bool = false
var is_dead : bool = false
var can_swin_up : bool  = true
var damage_fall : bool = false
var damage_fall_value : int = 0
func _ready() -> void:
	speed = MAX_SPEED
	health = MAX_HEALTH
	energy = MAX_ENERGY
	GRAVITY = (2*JumpHeight)/pow(TimeToJumpPeak,2)
	JumpForce = GRAVITY * TimeToJumpPeak

func damage(Damage : int )->void:
	velocity.x = 0
	animPlayer.play("damage")
	is_damaged=true
	finalAttack()
	health -=Damage
	if health <= 0:
		die()
	pass
func finalAttack()->void:
	attacking = false
	pass
func finalDamaged()->void:
	is_damaged = false
	
func die()->void:
	is_dead = true
	velocity.x = 0
	animPlayer.play("die")
	pass

func set_water_state(w_state : bool )->void:
	in_water = w_state
	
func set_gravity(delta:float)->void:
	if is_on_floor(): return
	velocity.y += GRAVITY * delta


func _on_water_detect_area_entered(area: Area2D) -> void:
	set_water_state(true)
	pass # Replace with function body.


func _on_water_detect_area_exited(area: Area2D) -> void:
	set_water_state(false)
	pass # Replace with function body.


func _on_water_can_up_area_entered(area: Area2D) -> void:
	can_swin_up = true
	pass # Replace with function body.


func _on_water_can_up_area_exited(area: Area2D) -> void:
	can_swin_up = false
	pass # Replace with function body.
