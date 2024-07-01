extends Area2D
@export_file("*.tscn") var StartMenu : String


func _on_body_entered(body: Node2D) -> void:
	LoadSreen.load_scene(StartMenu)
	pass # Replace with function body.
