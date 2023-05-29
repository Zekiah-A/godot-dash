extends Area2D

signal yellow_pad_entered

@export var reverse: bool = false
@onready var player: = get_node("/root/Scene/Player")

func _ready() -> void:
	connect("yellow_pad_entered", Callable(player, "_on_YellowPad_area_entered").bind(reverse)) # connect pad function to player'


func _on_YellowPad_area_entered(_area: Area2D) -> void:
	emit_signal("yellow_pad_entered")
