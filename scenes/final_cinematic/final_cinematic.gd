extends Control

const TALK_SOUNDS = [
	"res://assets/audio/dialogue_1.ogg",
	"res://assets/audio/dialogue_2.ogg",
	"res://assets/audio/dialogue_3.ogg",
	"res://assets/audio/dialogue_4.ogg"
]
const DIALOGUES = {
	0: "[b]Hola bbsita[/b] no te pongas tristona reina",
	1: "Voy a contarte [b]unos chistecitos[/b] xra k te rias un poco gatita jeje",
}
var jokes = [
	"¿Cómo se emborrachan los pingüinos? Con Licor del Polo.",
	"¿Qué guarda Darth Vader en su nevera? Helado oscuro.",
	"¿Sabías que en en Hawái no te hospedan?: te alohan.",
	"¿Qué pasa si tiras un pato al agua? Nada.",
	"Un policía me detuvo y me dijo 'papeles'? y yo le dije ¡Tijeras! y me disparó 22 veces en los pulmones",
	"¿Qué le dice un jardinero a otro? Seamos felices mientras podamos.",
	"¿Cómo queda un mago después de comer? Magordito.",
	"¿Qué le dice una impresora a otra? ¿Esa hoja es tuya o es impresión mía?"
]
var jokes_used = []
var jokes_index := -1

func _ready():
	$RatText.text = ""
	await get_tree().create_timer(2).timeout
	jokes_index = 0
	$RatText.text = DIALOGUES[0]
	play_talk_sound()

func play_talk_sound():
	var audio_clip = TALK_SOUNDS.pick_random()
	$"../AudioStreamPlayer".stream = load(audio_clip)
	$"../AudioStreamPlayer".play()

func _input(event):
	if jokes_index != -1 \
		and event is InputEventMouseButton and event.pressed \
		and event.button_index == 1:
		play_talk_sound()
		
		jokes_index += 1
		var max_jokes = Global.jokes_collected + 2
		if jokes_index == 1:
			$RatText.text = DIALOGUES[1]
		elif max_jokes > jokes_index:
			if jokes_index > 2:
				laugh()
			else:
				$"../Sprites/Sprite2D2/AnimationPlayer".play("idle")
				$"../MountainStreamPlayer".stop()
			jokes_used = jokes.duplicate()
			jokes.shuffle()
			var current_joke = jokes.pop_front()
			$RatText.text = current_joke
		elif max_jokes + 1 > jokes_index:
			laugh()
			$RatText.text = "He encontrado [b]" + str(Global.jokes_collected) \
				+ " chistecitoh[/b], espero que te hayan gustado gatita!!"
		elif max_jokes + 2 > jokes_index:
			laugh()
			$RatText.text = "[b]FIN[/b]\nPulsa para volver a jugar."
		else:
			get_tree().change_scene_to_file("res://scenes/gameplay/gameplay.tscn")
			queue_free()

func laugh():
	$"../Sprites/Sprite2D2/AnimationPlayer".play("laugh")
	$"../MountainStreamPlayer".stream = load("res://assets/audio/risa-montana.ogg")
	$"../MountainStreamPlayer".play()
