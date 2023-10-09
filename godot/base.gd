extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var changeanim = $changeanim
onready var player = $player

onready var spawnpoint = Vector2(180, 300)
onready var cheatpoint = Vector2(2300, 300)

onready var start = $CanvasLayer/start
onready var end = $CanvasLayer/ending

signal next

var state = "play"
var level = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	player.visible = false
	end.visible = false
	changeanim.play_backwards("fade")
	start.visible = true
	yield(self, "next")
	texting()
	

	
func _input(event):
	if Input.is_action_just_pressed("cheat"):
		player.position = cheatpoint
	
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("next")
		
func texting():
	state = "anim"
	changeanim.play("fade")
	yield(changeanim, "animation_finished")
	
	get_tree().paused = true
	
	for i in get_children():
		if i.is_in_group("room"):
			i.queue_free()
			
	get_tree().paused = false
	player.position = spawnpoint
	start.visible = false
	
	var path = "res://cutscenes/texting.tscn"
	var newroom = load(path).instance()
	call_deferred("add_child", newroom)

	changeanim.play_backwards("fade")
	yield(changeanim, "animation_finished")
	yield(get_tree().create_timer(0.4), "timeout")


func startgame():
	state = "anim"
	changeanim.play("RESET")
	var newroom = load("res://rooms/1.tscn").instance()
	call_deferred("add_child", newroom)
	
	player.position = spawnpoint
	player.visible = true
	
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
	
	player.animtree.travel(player.idle[level-1])
	
	#PLAY SCARF ANIMATION THINGS HERE NOW!
	
	get_tree().paused = false
	
	changeanim.play("anim")
	yield(changeanim, "animation_finished")
	
	
	changeanim.play_backwards("fade")
	yield(changeanim, "animation_finished")
	yield(get_tree().create_timer(0.01), "timeout")
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
	

func end_cutscene():
	state = "anim"
	changeanim.play("fade")
	yield(changeanim, "animation_finished")
	
	get_tree().paused = true
	
	for i in get_children():
		if i.is_in_group("room"):
			i.queue_free()
			
	get_tree().paused = false
	player.position = spawnpoint
	
	var path = "res://cutscenes/ending.tscn"
	var newroom = load(path).instance()
	call_deferred("add_child", newroom)
	
	newroom.position = Vector2(0, 0)
	
	changeanim.play_backwards("fade")
	yield(changeanim, "animation_finished")
	
	
func endgame():
	player.visible = false
	state = "anim"
	changeanim.play("fade")
	yield(changeanim, "animation_finished")
	
	get_tree().paused = true
	
	for i in get_children():
		if i.is_in_group("room"):
			i.queue_free()
			
	get_tree().paused = false
	player.position = spawnpoint
	
	end.visible = true

	changeanim.play_backwards("fade")
	yield(changeanim, "animation_finished")
	
