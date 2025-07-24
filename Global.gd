extends Node

@warning_ignore("unused_signal")
signal player_bounced_on_trampoline
@warning_ignore("unused_signal")
signal a_rock_was_destroyed

var rock_manager: Node

var jokes_collected: int = 0

# SHAKE NODES
const _shake_level: float = 30
const _duration: float = .25
const _frequency: int = 10
const _property_to_shake: String = "position"
func create_shake_node2d_tween(node: Node2D, __shake_level: float = _shake_level, duration: float = _duration, frequency: float = _frequency, property_to_shake: String = _property_to_shake) -> Tween:
	var tween: Tween = get_tree().create_tween()
	var period = duration / frequency
	for i in range(frequency - 1):
		tween.tween_property(node, property_to_shake, node.position + get_random_offset(), period)
	tween.tween_property(node, property_to_shake, node.position, period)
	return tween

func get_random_offset() -> Vector2:
	return Vector2(randf_range(-_shake_level, _shake_level), randf_range(-_shake_level, _shake_level))
