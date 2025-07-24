extends Node2D

@export var player: CharacterBody2D
var tutorial_started: bool = false
var time_stopped: bool = false
var rock: RigidBody2D
@onready var rock_scene: PackedScene = load("res://scenes/gameplay/rock/rock.tscn")
@export var rock_spawn_position: Marker2D

func _on_player_entered():
	if not tutorial_started:
		tutorial_started = true
		rock = rock_scene.instantiate()
		rock.TIME_TO_START_FALLING = 0 #freeze = false
		#rock.do_launch_rock()
		rock.rock_destroyed.connect(_on_rock_destroyed)
		rock_spawn_position.call_deferred("add_child",rock)

func show_tutorial():
	$DrawLineGraphic.global_position = rock.global_position - Vector2(100,0)
	$DrawLineGraphic.show_tutorial()
	
func _on_rock_destroyed():
	$DrawLineGraphic.destroy_tutorial()
	player.process_mode = Node.PROCESS_MODE_INHERIT

func _process(_delta):
	if not time_stopped and rock != null and is_instance_valid(rock):
		if rock.position.y > 1000:
			rock.queue_free()
			_on_rock_destroyed()
		if player.global_position.y - rock.global_position.y <= 150:
			time_stopped = true
			show_tutorial()
			rock.call_deferred("set_sleeping", true)
			player.process_mode = Node.PROCESS_MODE_DISABLED
