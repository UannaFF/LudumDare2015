
extends "res://scripts//enemies.gd"
const salt_class = preload("res://res//saltyNewMonster.gd")
const spice_class = preload("res://res//spicyMonster.gd")
# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initalization here
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
