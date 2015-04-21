extends "res://scripts/enemies.gd"

	
#func searchFood():
#	var cookPos = get_tree().get_node("level1/cook")
#	var my_pos = get_position_in_parent()
#	
#	#x movement
#	if(cookPos.x>my_pos.x):
#		vel.x+=force_fly
#	else:
#		vel.x-=force_fly
#		
#	#y movement
#	if(cookPos.y>my_pos.y):
#		vel.y+=force_fly
#	else:
#		vel.y-=force_fly
#	searchFood()
#	desp = vel*delta
#	desp = move(desp)
#	pass

func _ready():
	# Initalization here
	get_node("anim").play("idle")
	type = "salt"

