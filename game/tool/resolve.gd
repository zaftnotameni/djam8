class_name Resolve extends RefCounted

static func at(node:Node,typ:Script,ignore_missing:=false) -> Node:
	assert(node, 'must provide a node')
	assert(node.is_inside_tree(), 'node must be in the tree')
	for c in node.get_children():
		if matches_type(c,typ): return c
	if ignore_missing:
		return null
	else:
		push_warning('tried to resolve missing component %s at %s' % [typ, node.get_path()])
		return null

static func matches_type(node:Node,typ:Script) -> bool:
	var s := node.get_script() as Script
	if not s: return false
	return s == typ
