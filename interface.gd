extends Node

class Damageable:
	func take_damage(attack:Attack):
		pass
















func get_all_descendants(node):
	var all_descendants = [node]
	
	var children = node.get_children()
	for child in children:
		all_descendants.append_array(get_all_descendants(child))
		
	return all_descendants

func _ready():
	if OS.has_feature("debug"):
		var all_nodes = get_all_descendants(get_tree().current_scene)
		for node in all_nodes:
			check_node(node)
	
	get_tree().node_added.connect(check_node)

func check_node(node):
	if "implements" in node:
		for interface in node.implements:
			var instance = interface.new()
			for method in instance.get_script().get_script_method_list():
				assert(method.name in node, "Interface error: " + node.name + " does not have the " 
				+ method.name + " method.")
