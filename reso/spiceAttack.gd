
extends KinematicBody2D
const sweet_class = preload("res://res/sweetMonster.gd")
const salt_class = preload("res://res/saltyNewMonster.gd")
const spice_class = preload("res://res/spicyMonster.gd")

const pinkDot = preload("res://images//pinkDot.tex")
const blackDot = preload("res://images//blackDot.tex")
const whiteDot = preload("res://images//whiteDot.tex")
const redDot = preload("res://images//redDot.tex")
var vel = Vector2()
var force = Vector2()
var desp = Vector2()
var izq = false

var kind = ""
var done = false

const rap = 600
# member variables here, example:
# var a=2
# var b="textvar"
func _fixed_process(delta):
	if(kind != "" and not done):
		set_flavour()
	force = Vector2(rap,0)
	if(izq):
		vel -= force*delta
	else:
		vel += force*delta
	desp = vel*delta
	desp = move(desp)
	
func set_flavour():
	done = true
	if(kind == "salt"):
		get_node("dot1").set_texture(whiteDot)
		get_node("dot2").set_texture(blackDot)
		get_node("dot3").set_texture(whiteDot)
		get_node("dot4").set_texture(blackDot)
	if(kind == "spice"):
		get_node("dot1").set_texture(redDot)
		get_node("dot2").set_texture(redDot)
		get_node("dot3").set_texture(redDot)
		get_node("dot4").set_texture(redDot)
	if(kind == "sugar"):
		get_node("dot1").set_texture(pinkDot)
		get_node("dot2").set_texture(pinkDot)
		get_node("dot3").set_texture(pinkDot)
		get_node("dot4").set_texture(pinkDot)

func _ready():
	get_node("anim").play("attack")
	set_fixed_process(true)
	get_node("disappear").start()


func _on_Area2D_body_enter( body ):
	if(kind == "sugar"):
		if(body extends sweet_class):
		#something bad for the player
			print("choco y se quedo")
			queue_free()
			pass
		elif((body extends salt_class or body extends spice_class) and not body.get_node("particles").is_emitting()):
			body.get_node("particles").set_texture(pinkDot)
			body.get_node("particles").set_emitting(true)
			body.get_node("particles").set_emit_timeout(10)
			body.set_escape(2)
			get_node("/root/global").addToSweeties(body)
			queue_free()
			pass
	elif(kind == "salt"):
		print("choco con sal")
		if(body extends salt_class):
		#something bad for the player
			print("choco y se quedo")
			queue_free()
			pass
		elif((body extends sweet_class or body extends spice_class)and not body.get_node("particles").is_emitting()):
			body.get_node("particles").set_texture(blackDot)
			body.get_node("particles").set_emitting(true)
			body.get_node("particles").set_emit_timeout(10)
			get_node("/root/global").addToSalties(body)
			body.set_escape(0)
			queue_free()
			pass
	elif(kind == "spice"):
		print("choco con spice")
		if(body extends spice_class):
		#something bad for the player
			print("choco y se quedo")
			queue_free()
			pass
		elif((body extends salt_class or body extends sweet_class) and not body.get_node("particles").is_emitting()):
			body.get_node("particles").set_texture(redDot)
			body.get_node("particles").set_emitting(true)
			body.get_node("particles").set_emit_timeout(10)
			get_node("/root/global").addToSpicies(body)
			body.set_escape(1)
			queue_free()
			pass

func _on_disappear_timeout():
	queue_free()
