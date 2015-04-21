extends Node
#Cook info

var lifes = 5
var size = 1
var spice = 50
var sugar = 50
var salt = 50
var enemies = 7
var reds = 2


#Lists of eatable enemies
var salties = []
var spicies = []
var sweeties = []
var current_scene = null
var root = null
var main_scene = null
var hearts = []

#Functions to add elements to the lists
func addToSalties(e):
	salties.append(e)
func addToSweeties(e):
	sweeties.append(e)
func addToSpicies(e):
	spicies.append(e)
	
func eraseLife():
	lifes -= 1
	if(lifes >= 0):
		hearts[0].hide()
		hearts.remove(0)
func showAllHearts():
	hearts = root.get_node("GUI/GUIroot").get_children()
	hearts.invert()
	for i in hearts:
		i.show()
	
func _ready():
	var _root=get_tree().get_root()
	root = _root.get_child(_root.get_child_count()-1)
	main_scene = root.get_node("BaseLevel")

#Transition from one scene to the other
func _goto_scene(scene):
	call_deferred("_deferred_goto_scene",scene)
	
	
func _deferred_goto_scene(scene):
	if(scene == "res://scenes/init.xml"):
		root.get_node("GUI/GUIroot").hide()
	else:
		root.get_node("GUI/GUIroot").show()
		showAllHearts()
	if(current_scene!=null):
		current_scene.queue_free()
	var s=ResourceLoader.load(scene)
	current_scene = s.instance()
	main_scene.add_child(current_scene)
	
# starts a fade out transition
#func fade_out():
#	root.get_node("anim").play("fadeout")
#
## starts a fade in transition
#func fade_in():
#	root.get_node("anim").play("fadein")