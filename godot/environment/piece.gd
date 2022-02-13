extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


export var tolevel:int

onready var base = get_node("/root/base")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_piece_body_entered(body):
	if body.is_in_group("player") && base.state == "play":
		base.change_scene(tolevel)
