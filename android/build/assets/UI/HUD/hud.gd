extends CanvasLayer
class_name  HUD

@export var player : Player
@export var EBar : TextureProgressBar
@export var HBar : TextureProgressBar
@export var gameMenu : CanvasLayer
@export var keyView1 : TextureRect
@export var keyView2 : TextureRect
@export var keyView3 : TextureRect
@export var joystick : VirtualJoystick
@export var seepBTN : TouchScreenButton
var keys = []
func _ready() -> void:
	visible = true
	keys = [keyView1,keyView2,keyView3]
	gameMenu.visible = false
func update_bars()->void:
	#EBar.max_value = player.MAX_ENERGY
	#HBar.max_value = player.MAX_HEALTH
	
	HBar.value = (player.health) * 0.56 + 25
	EBar.value = player.energy * 0.85 + 9

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().paused = true
		gameMenu.visible = true
		pass
	pass
func update_key()->void:
	for i in keys:
		i.visible = false
	for i in range(0,player.keys):
		keys[i].visible = true
	pass
func updateHPBAR()->void:
	HBar.value = (player.health) * 0.56 + 25
func updateEBAR()->void:
	EBar.value = (player.energy) * 0.85 + 9 
func update_all()->void:
	update_key()
	update_bars()
	update_key()

