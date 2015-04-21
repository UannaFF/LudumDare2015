extends "res://scripts/enemies.gd"
var sweet_class
var salt_class

var dir = 1
# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initalization here
	sweet_class = load("res://res/sweetMonster.gd")
	salt_class = load("res://res/saltyNewMonster.gd")
	get_node("anim").play("idle")
	get_node("particles").set_emitting(false)
	type = "spice"
	set_fixed_process(true)




func _on_checkOtherEnemies_body_enter( body ):
	if(escaping == 0 and body extends salt_class):
		get_node("/root/global").salties.erase(self)
		get_node("/root/global").enemies -= 1
		queue_free()
	elif(escaping == 2 and body extends sweet_class):
		get_node("/root/global").sweeties.erase(self)
		get_node("/root/global").enemies -= 1
		queue_free()