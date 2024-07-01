extends Entity
class_name  Player

const MAX_KEY = 3
@export var rollSpeed : float = 4
@export var keys : int = 0

@export var hud : HUD
@export var dialogueMenu : DialogueMenu

@export var swim_speed : float = 500
@onready var ghostMarker : Marker2D = $GhostMarker
@onready var collision : CollisionShape2D = $Collision
const jump_strentgh : float = 0.7
var can_input : bool = true
var is_rolling : bool = false
var is_climbing : bool = false
var can_climb : bool = false
var on_platfrom : bool = false
var attack2Skill : bool = false
var rollSkill: bool = false
var last_dir : int = 0
var is_action : bool = false
var can_rolling : bool = false
var can_attack2 : bool = false
var attack_force : float = 0.0
###TEST
var climbingHeight : float = 420
var climbTargetHeight : float   = 0
var climbingLenght := 70
var climbingTargetLenght := 0.0
signal PlayerDead
@export var joysticl :VirtualJoystick
enum{
	IDLE_STATE,
	WATER_STATE,
	ACTION_STATE,
	ATTACKING_STATE,
	ROLL_STATE,
	DEAD_STATE,
	CLIMB_STATE,
	DAMAGED_STATE
}
var player_state = IDLE_STATE

func _ready() -> void:
	super._ready()
	energy = 0
	###test 
	hud.update_all()
	can_input = true
	
	###########
	hud.visible = false
	#is_action = true
func _process(delta: float) -> void:
	set_state()
	anim_state()
	pass

func _physics_process(delta: float) -> void:
	_print_debug()
	var direction : float = joysticl.dir_x
	if direction : 
		last_dir = get_last_dir(direction)
	climbing()
	match player_state:
		IDLE_STATE:
			set_gravity(delta)
			move(direction, delta)
		WATER_STATE:
			swim()
		ATTACKING_STATE:
			set_gravity(delta)
			velocity.x = move_toward(velocity.x , 0 , MAX_SPEED*0.2)
		CLIMB_STATE:
			if global_position.y > climbTargetHeight:
				global_position.y -= 10
			elif global_position.x != climbingTargetLenght:
				global_position.x = move_toward(global_position.x,climbingTargetLenght,10)
			else:
				finalClimb()
				
			pass
		DAMAGED_STATE:
			set_gravity(delta)
	
	move_and_slide()
	pass
###Private Methods
func move(direction : float, delta : float)->void:
	if !can_input:return
	if is_on_floor():
		if damage_fall:
			damage_fall = false
			damage(damage_fall_value)
			return
		attack(delta)
		#if Input.get_action_strength("up")>jump_strentgh:
		if Input.is_action_pressed("jump"):
			Input.action_release("jump")
			jump()
		elif joysticl.dir_y > 0.7 and on_platfrom:
			set_collision_mask_value(6,false)
	elif velocity.y > 3500:
		damage_fall = true
		damage_fall_value = int((velocity.y - 3000) / 500) * 10
		
	if direction:
		velocity.x = speed * direction
		scale.x = scale.y * flip_dir(direction)
	else:
		velocity.x = move_toward(velocity.x,0,MAX_SPEED*friction_x)
	pass
func attack(delta : float)->void:
	if Input.is_action_pressed("attack2") and !attacking:
		attack_force += 1 * delta
	elif Input.is_action_just_released("attack2"):
		if attack_force < 1:
			attack1()
		elif can_attack2:
			attack2()
		attack_force = 0.0
	pass
func swim()->void:
	if !can_input: return
	var swin_dir : Vector2 = Vector2(joysticl.dir_x, joysticl.dir_y).normalized()

	if swin_dir != Vector2.ZERO:
		velocity.y = swin_dir.y * swim_speed
		velocity.x = swin_dir.x * swim_speed
		if swin_dir.x != 0:
			scale.x = scale.y * flip_dir(swin_dir.x)
	else:
		velocity.x = move_toward(velocity.x,0,friction_x*swim_speed/2)
		velocity.y = move_toward(velocity.y,0,friction_x*swim_speed /2 )
	if !can_swin_up and velocity.y < 0: velocity.y = 0
	pass
func climbing()->void:
	if !can_input :  return
	#if Input.get_action_strength("up") > jump_strentgh and can_climb:
	#if (joysticl.dir_y<-0.5 or  joysticl.dir_x != 0 )and can_climb:
	if can_climb:
		print("OK")
		climb(last_dir)

func get_last_dir(dir :float)->int:
	if dir < 0:return -1
	else :return 1
	pass

func climb(dir : int)->void:
	velocity.y = 0
	velocity.x =0
	climbTargetHeight = global_position.y - climbingHeight
	climbingTargetLenght = global_position.x + climbingLenght * dir
	is_climbing = true
	can_climb = false
	damage_fall = false
	can_input = false
	animPlayer.play("climb")
	pass
func finalClimb()->void:
	is_climbing = false
	can_climb = false
	can_input = true

func get_dir()->float:
	return Input.get_action_strength("right") - Input.get_action_strength("left")

func emit_death_signal()->void:
	emit_signal("PlayerDead")

func flip_dir(direction : float)->int:
	if direction < 0:
		return -1
	else:
		return 1
	pass
func jump()->void:
	velocity.y = -JumpForce
	pass
	
func set_state()->void:
	if is_action:
		player_state = ACTION_STATE
	elif is_dead:
		player_state = DEAD_STATE
	elif is_damaged:
		player_state = DAMAGED_STATE
	elif attacking:
		player_state = ATTACKING_STATE
	elif is_rolling:
		player_state = ROLL_STATE
	elif is_climbing:
		player_state = CLIMB_STATE
	elif in_water:
		player_state = WATER_STATE
	else:
		player_state = IDLE_STATE

func anim_state()->void:
	match player_state:
		IDLE_STATE:
			if is_on_floor():
				if velocity.x == 0:
					animPlayer.play("idle")
				elif velocity.x < 400 and velocity.x > -400:
					animPlayer.play("walk")
				else:
					animPlayer.play("run")
			else:
				if velocity.y < 0:
					animPlayer.play("jump")
				elif velocity.y > 400:
					animPlayer.play("fall")
		WATER_STATE:
			animPlayer.play("idle")

		
			pass

func _print_debug()->void:
	
	pass
	
	
func attack1()->void:
	can_input = false
	attacking = true
	animPlayer.play("attack1")
	pass
func attack2()->void:
	can_input = false
	attacking = true
	animPlayer.play("attack2")
	pass

func finalAttack()->void:
	super.finalAttack()
	can_input = true
	$Attack1/CollisionShape2D.set_deferred("disabled", true)
	###Public Methods
func addHP(valueHp : int)->void:
	health += valueHp
	health = clamp(health,0,MAX_HEALTH)
	hud.updateHPBAR()

func addEnergy(valueE : int)->void:
	energy += valueE
	energy = clamp(energy,0,MAX_ENERGY)
	hud.updateEBAR()

func addKey(valueK : int)->void:
	keys += valueK
	keys= clamp(0,keys,MAX_KEY)
	hud.update_key()
	pass

func damage(damagevalue : int)->void:
	super.damage(damagevalue)
	can_input = false
	hud.update_bars()
	pass
func finalDamaged()->void:
	super.finalDamaged()
	can_input = true
	is_climbing = false
	pass
###HUD Public methods
func set_dialogue(num_dialogue : int)->void:
	can_input = false
	velocity.x = 0
	dialogueMenu.set_dialogue(num_dialogue)


func _on_dialogue_menu_dialogue_completed() -> void:
	can_input = true
	pass # Replace with function body.
func set_water_state(in_water_bool : bool)->void:
	in_water = in_water_bool
	damage_fall = false
	pass
func die()->void:
	is_dead = true
	velocity.x = 0
	
	set_collision_layer_value(2,false)
	animPlayer.play("die")


func _on_attack_1_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.damage(DAMAGE_FORCE,self)
	elif body.has_method("damage"):
		body.damage(DAMAGE_FORCE)
	pass # Replace with function body.


func _on_platform_detect_body_entered(body: Node2D) -> void:
	on_platfrom = true
	pass # Replace with function body.


func _on_platform_detect_body_exited(body: Node2D) -> void:
	on_platfrom = false
	set_collision_mask_value(6,true)
	pass # Replace with function body.


func _on_attack_1_area_entered(area: Area2D) -> void:
	if area.has_method("damage"):
		area.damage()
	pass # Replace with function body.

func set_is_action(value: bool)->void:
	is_action = value
