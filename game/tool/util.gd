@tool
### utility kit for tool scripts
class_name ToolUtil extends RefCounted

### creates a convenience hook for applying tool scripts (on save) instead of using the checkbox hack
static func on_pre_save(what: int, fn:Callable) -> void: if what == Node.NOTIFICATION_EDITOR_PRE_SAVE: await fn.call()

### setting process = always is dangerous on tool scripts, this sets it to inherit in the editor
static func set_process_always_safe_for_tool(node:Node):
	node.process_mode = Node.ProcessMode.PROCESS_MODE_INHERIT if Engine.is_editor_hint() else Node.ProcessMode.PROCESS_MODE_ALWAYS

### some tool scripts should only run if they are the root of the edited scene
static func is_root_of_edited_scene(node:Node) -> bool:
	if not Engine.is_editor_hint(): return false
	if not node: return false
	if not node.get_tree(): return false
	if not node.get_tree().edited_scene_root: return false
	if node.get_tree().edited_scene_root == node: return true
	return false

### some tool scripts should only run if they belong to the root of the edited scene
static func is_owned_by_edited_scene(node:Node) -> bool:
	if not Engine.is_editor_hint(): return false
	if not node: return false
	if not node.get_tree(): return false
	if not node.get_tree().edited_scene_root: return false
	if not node.owner: return false
	if node.get_tree().edited_scene_root == node.owner: return true
	return false

### children added via tool script get a meta tag, so they can be safetly cleaned up later
static func tool_add_child(parent:Node, child:Node):
	if not Engine.is_editor_hint(): return false
	parent.add_child.call_deferred(child)
	await child.ready
	child.set_meta('created_via_tool_script', true)
	child.owner = parent.get_tree().edited_scene_root

### uses the meta tag to only remove children that were created via tool script
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
