extends Control



@export var MenuBTNS : Control
@export var ProfileMenu : CanvasLayer
@export var ExitMenu : CanvasLayer
func _ready() -> void:
	ExitMenu.connect("QuitCancel", backQuit)
	MenuBTNS.visible = true
	ExitMenu.visible = false
	ProfileMenu.visible = false


func _on_exit_btn_pressed() -> void:
	show_and_hide(ExitMenu,MenuBTNS)
	pass



func _on_start_btn_pressed() -> void:
	show_and_hide(ProfileMenu, MenuBTNS)

	
func backQuit()->void:
	show_and_hide(MenuBTNS,ExitMenu)
	pass

func show_and_hide(show_node  , hide_node)->void:
	show_node.visible = true
	hide_node.visible = false
	pass


func _on_profile_change_load_cacel() -> void:
	show_and_hide(MenuBTNS,ProfileMenu)
	pass # Replace with function body.
