extends Control

var _selected_level: String = "Trigger Test"
var new_pos: Vector2
const selection_width: int = 1920
var _pos_tween
onready var _levels = get_node("Levels")

func _ready() -> void:
	_levels.rect_size.x = _levels.get_child_count() * OS.get_window_size().x
	_levels.rect_position.x = CurrentLevel.current_lvl_selector_page
	if !MenuLoop.is_playing_menuloop(): MenuLoop.play_menuloop()
#	$"Level Menu/Play Level/VBoxContainer/Label".text = selected_level
	$FadeScreen.show()
	$FadeScreen.fade_out()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		$FadeScreen.show()
		$FadeScreen.fade_in()
		CurrentLevel.scene_to_go = "res://src/scenes/StartScreen.tscn"
	if Input.is_action_just_pressed("ui_left"): _on_Left_pressed()
	if Input.is_action_just_pressed("ui_right"): _on_Right_pressed()

func _on_GoBackButton_button_up() -> void:
	if $GoBackButton.is_hovered():
		$FadeScreen.show()
		$FadeScreen.fade_in()
	CurrentLevel.scene_to_go = "res://src/scenes/StartScreen.tscn"

func _on_FadeScreen_fade_finished() -> void:
	if !CurrentLevel.scene_to_go == "null":
		get_tree().change_scene(CurrentLevel.scene_to_go)
	$FadeScreen.hide()

func _on_Left_pressed() -> void:
	if _pos_tween: _pos_tween.kill()
	_pos_tween = create_tween()
	_levels.rect_position = new_pos # snaps in case the tween hasn't finished animating
	new_pos = Vector2(int(_levels.rect_position.x+selection_width), _levels.rect_position.y)
	if new_pos.x >= selection_width:
		new_pos.x = -selection_width * (_levels.get_child_count() - 1)
	_pos_tween.tween_property(_levels, "rect_position", new_pos, 0.25).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	CurrentLevel.set_current_page(new_pos.x)

func _on_Right_pressed() -> void:
	if _pos_tween: _pos_tween.kill()
	_pos_tween = create_tween()
	_levels.rect_position = new_pos # snaps in case the tween hasn't finished animating
	new_pos = Vector2(int(_levels.rect_position.x-selection_width) % int(_levels.rect_size.x), _levels.rect_position.y)
	_pos_tween.tween_property(_levels, "rect_position", new_pos, 0.25).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	_pos_tween.play()
	CurrentLevel.set_current_page(new_pos.x)
