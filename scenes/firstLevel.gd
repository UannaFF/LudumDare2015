
extends Node2D


func _fixed_process(delta):
	if(get_node("/root/global").lifes <= 0 or (get_node("/root/global").enemies == get_node("/root/global").reds)):
		get_node("/root/global")._goto_scene("res://scenes/init.xml")
	if(get_node("/root/global").enemies <= 1):
		get_node("/root/global")._goto_scene("res://scenes/final.xml")
		
func _ready():
	get_node("/root/global").lifes = 5
	get_node("/root/global").reds = 2
	get_node("/root/global").enemies = 6
	get_node("/root/global").salties.clear()
	get_node("/root/global").spicies.clear()
	get_node("/root/global").sweeties.clear()
	set_fixed_process(true)


