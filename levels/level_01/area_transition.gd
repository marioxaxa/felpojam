extends Area3D

@export_file("*.tscn") var next_scene_path: String

func _on_body_entered(body):
	if body.is_in_group("player"):
		# Desativa a área para não acionar a transição várias vezes.
		set_deferred("monitoring", false)
		# Chama o nosso gerenciador de transição global.
		TransitionLayer.transition_to(next_scene_path)
