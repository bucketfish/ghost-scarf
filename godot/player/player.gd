extends KinematicBody2D

var speed = -300
onready var sprite = $ghost
var screensize

onready var base = get_node("/root/base")
onready var anim = $anim
onready var animtree = $animtree.get("parameters/playback")
onready var sadanim = $sad

var go = ["go_short", "go_mid", "go_long"]
var idle = ["idle_short", "idle_mid", "idle_long"]

# Called when the node enters the scene tree for the first time.
func _ready():
	screensize = get_viewport_rect().size
	
func _process(delta):
	if base.state == "play":
		position_ghost(delta)
	
func position_ghost(delta):
	var mousepos = get_global_mouse_position()
	var velocity = Vector2.ZERO
	rotation = position.angle_to_point(mousepos)
	
	if position.distance_to(mousepos) > 50:
		velocity = Vector2(speed,0).rotated(rotation)
		animtree.travel(go[base.level-1])
	else:
		animtree.travel(idle[base.level-1])

		
	if (position.angle_to_point(mousepos) > (PI/2) || position.angle_to_point(mousepos) < -(PI/2) ):
		anim.play("right")
	else:
		anim.play("left")

	rotation = rotation - PI if !sprite.flip_h else rotation

	move_and_slide(velocity)
	position.y = clamp(position.y, 0, screensize.y)


func sad():
	sadanim.play("sad")
