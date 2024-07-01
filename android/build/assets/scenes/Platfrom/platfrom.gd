extends CharacterBody2D
class_name Platform

@export_category("Temporary")
@export var is_Temporary : bool = false
@export var timeToDisappear: float = 2
@export var timeToAppearance : float =2

@export_category("Nodes")
@export var playerDetected : Area2D
@export var collisionPlatform : CollisionShape2D
var timerDisappear : Timer
var timerAppearance : Timer

func _ready() -> void:
	playerDetected.monitoring = is_Temporary
	if is_Temporary:
		timerAppearance = Timer.new()
		timerDisappear = Timer.new()
		add_child(timerDisappear)
		add_child(timerAppearance)
		timerDisappear.wait_time = timeToDisappear
		timerAppearance.wait_time = timeToAppearance
		timerAppearance.connect("timeout",appearancePlatfrom)
		timerDisappear.connect("timeout",disappearPlatfrom)





func _on_player_detected_body_entered(body: Node2D) -> void:
	if body is Player and is_Temporary:
		timerDisappear.start()

func appearancePlatfrom()->void:
	collisionPlatform.disabled = false
	visible = true

func disappearPlatfrom()->void:
	collisionPlatform.disabled = true
	visible = false
	timerAppearance.start()
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
