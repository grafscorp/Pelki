extends CanvasLayer
class_name  LoadScreenScene
var loadingScene : String
@export var animPlayer : AnimationPlayer
func _ready() -> void:
	visible = false
	animPlayer.pause()
	set_process(false)


func _process(delta: float) -> void:
	if ResourceLoader.load_threaded_get_status(loadingScene) == ResourceLoader.THREAD_LOAD_LOADED:
		var newScene : PackedScene = ResourceLoader.load_threaded_get(loadingScene)
		get_tree().change_scene_to_packed(newScene)
		animPlayer.pause()
		visible = false
		get_tree().paused = false
		set_process(false)
		pass

func load_scene(sceneName : String) ->void:
	animPlayer.play()
	visible = true
	loadingScene = sceneName
	ResourceLoader.load_threaded_request(sceneName)
	set_process(true)
	pass
