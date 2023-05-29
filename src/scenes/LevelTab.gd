extends Control

@export var used_level: PackedScene
@export var path: StringName

func _ready() -> void:
	$LevelMenu/LevelButton/VBoxContainer/Label.text = name
	$LevelMenu/LevelButton._selected_level = name
	$LevelMenu/LevelButton._selected_level_scene = used_level
