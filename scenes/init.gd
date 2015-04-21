
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _fixed_process(delta):
	if(Input.is_action_pressed("entrar")):
		get_node("/root/global")._goto_scene("res://scenes/firstLevel.xml")

func _ready():
	set_fixed_process(true)
	pass


