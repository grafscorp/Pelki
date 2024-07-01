extends Node2D
@export var player:Player
@export var rayNW : RayCast2D
@export var rayNW2 : RayCast2D
@export var rayW:RayCast2D

func _physics_process(delta: float) -> void:
	climb()
	pass

func climb()->void:
	if !player.can_input: return
	if !rayNW.is_colliding() and !rayNW2.is_colliding() and rayW.is_colliding():
		player.can_climb = true
	else:
		player.can_climb = false
