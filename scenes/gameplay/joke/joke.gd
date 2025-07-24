extends Node2D

func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		Global.jokes_collected += 1
		$Area2D.queue_free()
		$AnimationPlayer.play("pickup")
		$CPUParticles2D.set_emitting(true)
		$AudioStreamPlayer.play()
		await get_tree().create_timer(1).timeout
		queue_free()
