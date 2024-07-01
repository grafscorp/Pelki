extends CanvasLayer

signal QuitCancel

func _on_confirm_btn_pressed() -> void:
	get_tree().quit()


func _on_cancel_btn_pressed() -> void:
	emit_signal("QuitCancel")
