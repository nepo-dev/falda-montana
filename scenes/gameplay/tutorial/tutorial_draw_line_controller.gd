extends Node2D

func show_tutorial():
	$AnimationPlayer.play("loop_draw_line")

func destroy_tutorial():
	$AnimationPlayer.pause()
	var tween = get_tree().root.create_tween()
	tween.tween_property($Pointer,"modulate",Color(0,0,0,0), 0.2)
	tween.tween_property($Line2D, "default_color", Color(0,0,0,0), 0.2)
	tween.tween_callback(queue_free)
