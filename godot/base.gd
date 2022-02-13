extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var changeanim = $changeanim
onready var player = $player

onready var spawnpoint = Vector2(180, 300)

var state = "play"
var level = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	state = "anim"
	yield(get_tree().create_timer(0.3), "timeout")
	changeanim.play_backwards("fade")
	yield(changeanim, "animation_finished")
	yield(get_tree().create_timer(0.4), "timeout")


func startgame():
	state = "anim"
	changeanim.play("RESET")
	var newroom = load("res://rooms/1.tscn").instance()
	call_deferred("add_child", newroom)
	
	player.position = spawnpoint
	
	get_tree().paused = false
	yield(get_tree().create_timer(0.3), "timeout")
	changeanim.play_backwards("fade")
	yield(changeanim, "animation_finished")
	yield(get_tree().create_timer(0.4), "timeout")
	state = "play"

func change_scene(tolevel):
	
	level = tolevel
	
	var path = "res://rooms/" + str(tolevel) + ".tscn"
	
	state = "anim"
	changeanim.play("fade")
	yield(changeanim, "animation_finished")
	
	get_tree().paused = true
	
	player.position = spawnpoint
	
	for i in get_children():
		if i.is_in_group("room"):
			i.queue_free()
	
	var newroom = load(path).instance()
	call_deferred("add_child", newroom)
	
	
	
	#PLAY SCARF ANIMATION THINGS HERE NOW!
	
	get_tree().paused = false
	yield(get_tree().create_timer(0.3), "timeout")
	
	changeanim.play_backwards("fade")
	yield(changeanim, "animation_finished")
	yield(get_tree().create_timer(0.4), "timeout")
	state = "play"
	
func die():
	player.sad()
	
	state = "anim"
	changeanim.play("fade")
	yield(changeanim, "animation_finished")
	
	player.position = spawnpoint
	
	
	changeanim.play_backwards("fade")
	yield(changeanim, "animation_finished")
	state = "play"
	
