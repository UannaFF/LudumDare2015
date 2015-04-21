
extends Node
var l

func _ready():
	get_node("/root/global")._goto_scene("res://scenes/init.xml")
	get_node("audio").play()

	


