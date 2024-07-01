extends CanvasLayer
class_name  GameMenu


@export var exitMenu : CanvasLayer
@export var menuBTNS : Control
@export var settingsMenu : CanvasLayer
@export var loadMenu : CanvasLayer
@export var playBTN : Button
func _ready() -> void:
	loadMenu.connect("LoadCacel",loadClosed)
	menuBTNS.visible = true
	exitMenu.visible = false
	loadMenu.visible = false
	#SettingsMenu.visible = false
	
func gameOver()->void:
	get_tree().paused = true
	visible = true
	playBTN.visible = false


func _on_exit_btn_pressed() -> void:
	show_and_hide(exitMenu,menuBTNS)


func _on_exit_menu_quit_cancel() -> void:
	show_and_hide(menuBTNS,exitMenu)


func show_and_hide(show_node,hide_node)->void:
	show_node.visible = true
	hide_node.visible = false


func _on_setting_btn_pressed() -> void:
	pass # Replace with function body.


func _on_load_btn_pressed() -> void:
	show_and_hide(loadMenu,menuBTNS)
func loadClosed()->void:
	show_and_hide(menuBTNS,loadMenu)
	pass


func _on_play_btn_pressed() -> void:
	get_tree().paused = false
	visible = false


func _on_player_player_dead() -> void:
	gameOver()
	pass # Replace with function body.
