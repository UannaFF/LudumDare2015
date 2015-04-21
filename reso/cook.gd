extends KinematicBody2D
const spiceText = preload("res://images//spice.tex")
const chispasText = preload("res://images//chispas.tex")
const saleroText = preload("res://images//salero.tex")
const spiceCloud = preload("res://res//spiceAttack.res")
const sweet_class = preload("res://res/sweetMonster.gd")
const salt_class = preload("res://res/saltyNewMonster.gd")
const spice_class = preload("res://res/spicyMonster.gd")
var vel = Vector2()
var force = Vector2()
var desp = Vector2()
var side = false
var new_side = true
var jumping = false
var weapon = "spice"
var canAttack = true

const gravity = 800.0
const force_walk = 300
const force_stop = 1500
const force_jump = 400
const max_air_time = 100
const max_vel =	200

var animations = ["idle","walk","jump","attack"]


# member variables here, example:
# var a=2
# var b="textvar"

func _fixed_process(delta):
	var stop = true
	force = Vector2(0,gravity)
	#set movement
	vel += force*delta
		
	#Control movement key
	var walk_left = Input.is_action_pressed("ui_left")
	var walk_right = Input.is_action_pressed("ui_right")
	var down = Input.is_action_pressed("ui_down")
	var jump = Input.is_action_pressed("jump")
	var Q = Input.is_action_pressed("salt")
	var W = Input.is_action_pressed("sugar")
	var E = Input.is_action_pressed("spice")
	var attack = Input.is_action_pressed("attack")
	
	var anim = get_node("animation")
	
	if (jumping):
		if(vel.y>0):
			jumping=false
		elif(down):
			vel.y*=-2
			
	
	if (walk_left):
		#Anim for walking
		if (vel.x<=0 and vel.x > -max_vel):
			vel.x-=force_walk
			new_side = false
			stop = false
	elif (walk_right):
		if (vel.x>=0 and vel.x < max_vel):
			vel.x+=force_walk
			new_side = true
			stop = false
	elif (jump):
		vel.y=-force_jump
		jumping = true
	
	#Changing the condiment
	var salero = get_node("rightArm/salero")
	if(Q):
		weapon = "salt"
		salero.set_texture(saleroText)
	elif(W):
		weapon = "sugar"
		salero.set_texture(chispasText)
	elif(E):
		weapon = "spice"
		salero.set_texture(spiceText)
		
	#Remaining movement when colliding
	if(is_colliding()):
		var p = get_collision_normal()
		desp = p.slide(desp)
		vel = p.slide(vel)
	
	#Changes animations
	if(vel.x != 0 and not jumping):
		if(anim.get_current_animation()!="walk" or not anim.is_playing()):
			anim.stop()
			anim.play("walk")
	elif(jumping):
		if(anim.get_current_animation()!="jump" or not anim.is_playing()):
			anim.stop()
			anim.play("jump")
	elif(attack and canAttack):
		#var current = anim.get_current_animation()
		if(anim.is_playing()):
			anim.stop()
		anim.play("attack")
		
		var my_pos = get_pos()
		var nodeCloud = spiceCloud.instance()
		#Generates the corresponding cloud, instanciating
		#nodeCloud.setFlavour(weapon)
		nodeCloud.kind = weapon
		if(new_side):
			nodeCloud.set_pos(Vector2(my_pos.x+70,my_pos.y-30))
		else:
			nodeCloud.set_pos(Vector2(my_pos.x-70,my_pos.y-30))
			nodeCloud.izq = true
		get_parent().add_child(nodeCloud)
		canAttack = false
		get_node("staph").start()
		
	else:
		pass
		if(anim.get_current_animation()!="attack"):
			anim.stop()
#			anim.play("idle")
			
	#Attack
#	if(attack):
##		var current = anim.get_current_animation()
##		if(current != "attack"):
#		anim.stop()
#		anim.play("attack")
			#anim.queue(current)
			
		
		
	#stoping movement
	if(stop):	
		var s = sign(vel.x)
		var mag = abs(vel.x)
		
		mag -= force_stop*delta
		if(mag < 0):
			mag = 0
		vel.x = mag*s
	
	#mirroring sprite when walking left or right
	if(side != new_side):
		if(new_side):
			get_node("body").set_scale( Vector2(1,1) )
		else:
			get_node("body").set_scale( Vector2(-1,1) )
			
		side = new_side
		
	desp = vel*delta
	desp = move(desp)
	
	pass

func _ready():
	set_fixed_process(true)
#	get_node("animation").play(animations[0])
	get_node("cam").make_current()

func _on_staph_timeout():
	canAttack = true
	pass

#Wake up enemies
func _on_Area2D_body_enter( body ):
	if(body extends sweet_class or body extends salt_class or body extends spice_class):
		body.activate(self)

func _on_Area2D_body_exit( body ):
	if(body extends sweet_class or body extends salt_class or body extends spice_class):
		body.deactivate()

func _on_lifeCounter_body_enter( body ):
	if(body extends sweet_class or body extends salt_class or body extends spice_class):
		get_node("/root/global").eraseLife()
		
