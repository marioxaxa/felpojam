extends Node


func _ready():
	SaveLoad._load()
	
	for dados in SaveLoad.SaveFileData.carimbos_dados:
		criar_instancia_carimbo(dados["pos"], dados["normal"])

func criar_instancia_carimbo(pos: Vector3, normal: Vector3):
	var carimbo_scene = preload("res://common/components/carimbada.tscn")
	var novo_carimbo = carimbo_scene.instantiate()
	
	get_tree().root.add_child(novo_carimbo)
	
	novo_carimbo.global_position = pos
	
	if normal.is_equal_approx(Vector3.UP) or normal.is_equal_approx(Vector3.DOWN):
		novo_carimbo.look_at(pos + normal, Vector3.RIGHT)
	else:
		novo_carimbo.look_at(pos + normal)
