extends Node2D

signal game_finished

@onready var player_character = $"../PlayerCharacter"

var final_cinematic = preload("res://scenes/final_cinematic/final_cinematic.tscn").instantiate()
var is_game_finished := false

func _process(_delta):
	if is_game_finished:
		return
	if player_character.position.y < position.y and !is_game_finished:
		is_game_finished = true
		game_finished.emit()
		$AudioStreamPlayer.play()
		SceneLoader.create_scene_loader($"..", "res://scenes/final_cinematic/final_cinematic.tscn")
