extends Control
export(String) var scene_path = ''
var level_manager = load("res://managers/LevelManager.gd").new()


func _ready() -> void:
# warning-ignore:return_value_discarded
	$CenterContainer/VBoxContainer/Play.connect('pressed', self, '_on_Play_pressed')
# warning-ignore:return_value_discarded
	$CenterContainer/VBoxContainer/Credits.connect('pressed', self, '_on_Credit_pressed')
# warning-ignore:return_value_discarded
	$CenterContainer/VBoxContainer/Quit.connect('pressed', self, '_on_Quit_pressed')
	

func _on_Play_pressed() -> void:
	level_manager.goto_scene('res://scenes/%s.tscn' % [scene_path])


func _on_Credit_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene('res://interfaces/menu/Credits.tscn')
	
	
func _on_Quit_pressed() -> void:
	get_tree().quit()
