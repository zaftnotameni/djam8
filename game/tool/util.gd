@tool
class_name ToolUtil extends RefCounted

static func on_pre_save(what: int, fn:Callable) -> void: if what == Node.NOTIFICATION_EDITOR_PRE_SAVE: await fn.call()

static func set_process_always_safe_for_tool(node:Node):
	node.process_mode = Node.ProcessMode.PROCESS_MODE_INHERIT if Engine.is_editor_hint() else Node.ProcessMode.PROCESS_MODE_ALWAYS

static func is_root_of_edited_scene(node:Node) -> bool:
	if not Engine.is_editor_hint(): return false
	if not node: return false
	if not node.get_tree(): return false
	if not node.get_tree().edited_scene_root: return false
	if node.get_tree().edited_scene_root == node: return true
	return false

static func is_owned_by_edited_scene(node:Node) -> bool:
	if not Engine.is_editor_hint(): return false
	if not node: return false
	if not node.get_tree(): return false
	if not node.get_tree().edited_scene_root: return false
	if not node.owner: return false
	if node.get_tree().edited_scene_root == node.owner: return true
	return false

static func tool_add_child(parent:Node, child:Node):
	if not Engine.is_editor_hint(): return false
	parent.add_child.call_deferred(child)
	await child.ready
	child.set_meta('created_via_tool_script', true)
	child.owner = parent.get_tree().edited_scene_root

static func remove_all_children_created_via_tool_from(node:Node):
	if not Engine.is_editor_hint(): return false
	for child:Node in node.get_children():
		if not child.has_meta('created_via_tool_script'): continue
		if not child.get_meta('created_via_tool_script'): continue
		printt('tool removing child', child, child.name)
		child.queue_free()
		await child.tree_exited

static func remove_all_children_dangerously_from(node:Node):
	if not Engine.is_editor_hint(): return false
	for child:Node in node.get_children():
		child.queue_free()
		await child.tree_exited
