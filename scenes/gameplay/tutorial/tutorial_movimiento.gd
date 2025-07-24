extends Node2D


func _ready():
	$DrawLineGraphic.show_tutorial()
	Global.player_bounced_on_trampoline.connect($DrawLineGraphic.destroy_tutorial)
