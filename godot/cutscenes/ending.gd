extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal next

var spaces = [357, 318, 278, 238, 180, 138, 99, 59, 22, -19, -54, -91, -146, -185, -225, -265, -303, -359, -394, -428, -468, -516]
onready var dialogue = $dialogue

onready var base = get_node("/root/base")
onready var sfx = $sfx

# Called when the node enters the scene tree for the first time.
func _ready():
	dialogue.position.y = spaces[0]
	play()

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("next")
		
func play():
	var cur = 1
	while cur < 22:
		yield(self, "next")
		sfx.stream_paused = false
		yield(get_tree().create_timer(0.2), "timeout")
		sfx.stream_paused = true
		dialogue.position.y = spaces[cur]
		
		cur += 1
	yield(self, "next")
	ended()
		
func ended():
	base.endgame()
	yield(base.changeanim, "animation_finished")
	queue_free()
	
