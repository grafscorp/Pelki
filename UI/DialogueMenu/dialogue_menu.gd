extends CanvasLayer
class_name DialogueMenu

@export var DText : RichTextLabel
@export var NText : Label
@export var DTimer : Timer
@export var player : Player
@export var NamePanel : Panel
var next_dlg : int = 0
var TextSize : int =0

signal DialogueCompleted

func _ready() -> void:
	DText.visible_characters = 0
	NamePanel.visible = false
	visible = false
	
func set_dialogue(num_dialogue : int)->void:
	if num_dialogue == 0: return
	DText.text = Root.dialogue[num_dialogue]["Text"]
	if Root.dialogue[num_dialogue]["Name"] != "":
		NText.text = Root.dialogue[num_dialogue]["Name"]
		NamePanel.visible = true
	else:
		NamePanel.visible = false
	next_dlg = Root.dialogue[num_dialogue]["Next"]
	visible = true
	DText.visible_characters = 0
	TextSize = DText.text.length()
	DTimer.start()
	pass




func _on_skip_dialogue_pressed() -> void:
	DTimer.stop()
	if DText.visible_characters >= TextSize:
		if next_dlg == 0:
			visible = false
			emit_signal("DialogueCompleted")
		else:
			set_dialogue(next_dlg)
	else:
		DText.visible_characters = TextSize
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	DText.visible_characters+=1
	if DText.visible_characters>=TextSize:
		DTimer.stop()
	pass # Replace with function body.
