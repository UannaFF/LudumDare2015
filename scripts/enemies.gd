extends KinematicBody2D


var type = ""
var chasing = false
#
var salados = []
var vel = Vector2()
var force = Vector2()
var desp = Vector2()
var chefi = null
const force_fly = 60
const force_fly_to_enemy = 70
const force_escape = 50
var eatingEnemy = false
var escaping = -1


func get_type():
	return type
func set_escape(i):
	escaping = i
	
func move_to_enemy(elem, delta):
	var his_pos = elem.get_pos()
	var my_pos = get_pos()
	if(his_pos.x>my_pos.x and his_pos.y>my_pos.y):
		force = Vector2(force_fly_to_enemy,force_fly_to_enemy)
	elif(his_pos.x>my_pos.x and his_pos.y<my_pos.y):
		force = Vector2(force_fly_to_enemy,-force_fly_to_enemy)
	elif(his_pos.x<my_pos.x and his_pos.y<my_pos.y):
		force = Vector2(-force_fly_to_enemy,-force_fly_to_enemy)
	elif(his_pos.x<my_pos.x and his_pos.y>my_pos.y):
		force = Vector2(-force_fly_to_enemy,force_fly_to_enemy)
	vel += force*delta
	desp = vel*delta
	desp = move(desp)
	if (is_colliding()):
		var n = get_collision_normal()
		vel = n.slide(vel)
		desp = n.slide(desp)
		move(desp)
	
func _fixed_process(delta):
	var salties = get_node("/root/global").salties
	var spicies = get_node("/root/global").spicies
	var sweeties = get_node("/root/global").sweeties
	eatingEnemy = false
	#First check if there is an enemy ñumi enough to eat, si no soy comible yo
	if(not get_node("particles").is_emitting()):
		#if he was escaping, erase from list
		if(escaping == 0):
			#salties
			salties.erase(self)
		elif(escaping == 1):
			#spicies
			spicies.erase(self)
		elif(escaping == 2):
			sweeties.erase(self)
			
		set_escape(-1)
			
		#move to edibles
		if(type == "salt"):
			if(not salties.empty()):
				move_to_enemy(salties[0], delta)
				eatingEnemy = true
		elif(type == "spice"):
			if(not spicies.empty()):
				move_to_enemy(spicies[0], delta)
				eatingEnemy = true
		elif(type == "sweet"):
			if(not sweeties.empty()):
				move_to_enemy(sweeties[0], delta)
				eatingEnemy = true
	
	if(chasing and not eatingEnemy):
		var his_pos = chefi.get_pos()
		var my_pos = get_pos()
		if(not get_node("particles").is_emitting()):
			if(his_pos.x>my_pos.x and his_pos.y>my_pos.y):
				force = Vector2(force_fly,force_fly)
			elif(his_pos.x>my_pos.x and his_pos.y<my_pos.y):
				force = Vector2(force_fly,-force_fly)
			elif(his_pos.x<my_pos.x and his_pos.y<my_pos.y):
				force = Vector2(-force_fly,-force_fly)
			elif(his_pos.x<my_pos.x and his_pos.y>my_pos.y):
				force = Vector2(-force_fly,force_fly)
		else:
			if(his_pos.x>my_pos.x and his_pos.y>my_pos.y):
				force = Vector2(-force_escape,-force_escape)
			elif(his_pos.x>my_pos.x and his_pos.y<my_pos.y):
				force = Vector2(-force_escape,force_escape)
			elif(his_pos.x<my_pos.x and his_pos.y<my_pos.y):
				force = Vector2(force_escape,force_escape)
			elif(his_pos.x<my_pos.x and his_pos.y>my_pos.y):
				force = Vector2(force_escape,-force_escape)
				
		vel += force*delta
		desp = vel*delta
		desp = move(desp)
		if (is_colliding()):
			var n = get_collision_normal()
			vel = n.slide(vel)
			desp = n.slide(desp)
			move(desp)
	

func activate(ch):
	chasing = true
	chefi = ch


func deactivate():
	chasing = false
	chefi = null