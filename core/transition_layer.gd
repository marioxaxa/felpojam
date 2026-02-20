extends CanvasLayer

@onready var animation_player = $AnimationPlayer
var next_scene_path = ""

# _ready é chamado apenas uma vez, quando o jogo inicia.
func _ready():
	# Conectamos ao sinal 'scene_changed' para saber quando uma nova cena foi carregada.
	get_tree().scene_changed.connect(_on_scene_changed)

func transition_to(scene_path: String):
	# Evita que uma nova transição comece se uma já estiver em andamento.
	if animation_player.is_playing() and animation_player.current_animation == "fade_to_white":
		return
		
	next_scene_path = scene_path
	animation_player.play("fade_to_white")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_to_white":
		# A troca de cena precisa ser deferida para acontecer de forma segura.
		get_tree().call_deferred("change_scene_to_file", next_scene_path)

# Esta função será chamada automaticamente pelo sinal 'scene_changed'.
func _on_scene_changed():
	# Toca a animação para revelar a cena.
	animation_player.play("fade_to_normal")
