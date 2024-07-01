extends CanvasLayer

signal LoadCacel

@export_file("*.tscn") var demo_level : String 

func _on_back_btn_pressed() -> void:
	emit_signal("LoadCacel")
	pass # Replace with function body.


func _on_profile_1_pressed() -> void:
	new_game()
	pass # Replace with function body.


func _on_profile_2_pressed() -> void:
	new_game()
	pass # Replace with function body.


func _on_profile_3_pressed() -> void:
	new_game()
	pass # Replace with function body.

func update_profiles()->void:
	
	pass

func new_game(num_profile: int = 0)->void:
	LoadSreen.load_scene(demo_level)
	pass
