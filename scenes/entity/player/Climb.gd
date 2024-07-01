extends Node2D
@export var player:Player
@export var rayNW : RayCast2D
@export var rayNW2 : RayCast2D
@export var rayW:Area2D
var is_walling : bool = false
var obj_wall : int = 0
func _physics_process(delta: float) -> void:

	climb()
	#print("wall : " + str(is_walling))
	#print("nwall2 : " + str(rayNW2.is_colliding()))
	#print("nwall : " + str(rayNW.is_colliding()))
	pass

func climb()->void:
	if !player.can_input:
		player.can_climb = false
		return
	if !rayNW.is_colliding() and !rayNW2.is_colliding() and is_walling:
		player.can_climb = true
		
	else:
		player.can_climb = false


func _on_ray_wall_body_entered(body: Node2D) -> void:
	obj_wall +=1
	is_walling = true
	pass # Replace with function body.


func _on_ray_wall_body_exited(body: Node2D) -> void:
	obj_wall -=1
	if obj_wall <=0:
		is_walling = false
	pass # Replace with function body.
