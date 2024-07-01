extends Area2D
class_name  Puzzle

@export var is_Active : bool = false#false
@export var need_Keys : int = 1
@export_range(0,360,1) var win_degrees : int = 5 
@export_category("Nodes")
@export var animPlayer :AnimationPlayer
@export var puzzlesSprite: Node2D
var target : TouchScreenButton = null
var spriteBUTTONS : Array = []
var active_elements : int = 0
@export var rotate_node  : Node2D 
var last_direction : float = 0.0
func _ready() -> void:
	randomize()
	set_physics_process(false)#false
	puzzlesSprite.visible = false
	
	for i  in (puzzlesSprite.get_children() ):
		spriteBUTTONS.append(i)
		i.get_child(0).rotation_degrees = randi_range(15,345) 
		i.pressed.connect(sprite_btn_press.bind(i))
		i.released.connect(sprite_btn_release)
		active_elements +=1 
func sprite_btn_press(button : TouchScreenButton)->void:
	if target != null: return
	target = button
	pass
func sprite_btn_release()->void:
	if target:
		var rotate_target_sprite = fmod(target.get_child(0).rotation_degrees, 360)
		if rotate_target_sprite <= win_degrees or rotate_target_sprite >= 360 - win_degrees:
			active_elements -=1
			target.shape = null
			target.get_child(0).rotation = 0
		target = null
		if active_elements <= 0:
			###FINISH
			set_physics_process(false)
			monitoring = false
			$Collision.disabled = true
			$KeyKey.visible = false
			animPlayer.play("action")
			pass
	
func _physics_process(delta: float) -> void:
	if is_Active and target:
		#var final_pos = get_global_mouse_position()
		#print(start_pos.angle_to_point(final_pos))
		#start_pos = final_pos
		rotate_node.look_at(get_global_mouse_position())
		target.get_child(0).rotation_degrees += _check_dir(last_direction,rotate_node.rotation_degrees)
		#target.get_child(0).rotation_degrees += get_speed_rotate(last_direction,rotate_node.rotation_degrees)
		last_direction = rotate_node.rotation_degrees
		
		#var final_pos = get_global_mouse_position()
		#var angle_mouse = rad_to_deg(start_pos.angle_to_point(final_pos))
		#start_pos = final_pos
		#var sp : Sprite2D
		#target.get_child(0).rotation_degrees = lerp(rotation_degrees,angle_mouse,1)
		pass
func _check_dir(last_dir: float , now_dir : float)->int:

	if now_dir > last_dir:
		return 1
	elif now_dir < last_dir:
		return -1
	return 0
	pass
func get_speed_rotate(last_dir : float, now_dir : float) ->float:
	return now_dir + last_dir
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if !is_Active:
			if body.keys < need_Keys:return
			body.addKey(-need_Keys)
			is_Active = true
			animPlayer.play("on")
		else:
			set_physics_process(true)
			animPlayer.play("show")
			pass
	

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		set_physics_process(false)
		if is_Active:
			animPlayer.play_backwards("show")
	pass # Replace with function body.

func turnOnPuzzle()->void:
	monitoring = false
	monitoring = true
	pass




