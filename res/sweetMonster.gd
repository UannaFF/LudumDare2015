
extends "res://scripts/enemies.gd"
var salt_class
var spice_class
# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initalization here
	salt_class = load("res://res/saltyNewMonster.gd")
	spice_class = load("res://res/spicyMonster.gd")
	get_node("anim").play("idle")
	get_node("particles").set_emitting(false)
	type = "sweet"
	set_fixed_process(true)




func _on_checkEnemies_body_enter( body ):
	if(escaping == 0 and body extends salt_class):
		get_node("/root/global").salties.erase(self)
		get_node("/root/global").enemies -= 1
		queue_free()
	elif(escaping == 1 and body extends spice_class):
		get_node("/root/global").spicies.erase(self)
		get_node("/root/global").enemies -= 1
		queue_free()
