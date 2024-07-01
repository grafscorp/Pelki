extends Control

@export_file("*.tscn") var StartMenu : String

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		nextScene()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	nextScene()

func nextScene()->void:
	LoadSreen.load_scene(StartMenu)
	pass
