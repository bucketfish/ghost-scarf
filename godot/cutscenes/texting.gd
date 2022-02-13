extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal next

var spaces = [-78, -156, -191, -231, -262, -295, -335, -391, -447, -503, -566, -638, -670, -706, -742, -799, -832, -888, -943, -983, -1047 ]
onready var dialogue = $dialogue

onready var base = get_node("/root/base")

# Called when the node enters the scene tree for the first time.
func _ready():
	dialogue.position.y = spaces[0]
	play()

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("next")
		
func play():
	var cur = 1
	while cur < 21:
		yield(self, "next")
		dialogue.position.y = spaces[cur]
		cur += 1
		
	base.startgame()
	queue_free()
	
