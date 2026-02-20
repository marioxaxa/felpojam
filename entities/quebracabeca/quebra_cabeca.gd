extends Area3D

@export var area_id: String = ""
@export var respostas_corretas: Array[String] = []

func _ready():
	self.area_entered.connect(_on_area_entered)

func _on_area_entered(area):
	var carimbo_raiz = area.get_parent() 
	
	if carimbo_raiz.has_method("obter_texto"):
		var texto = carimbo_raiz.obter_texto()
		
		if verificar_resposta(texto):
			print("Resposta correta detectada!")

func verificar_resposta(texto: String) -> bool:
	for resposta in respostas_corretas:
		if texto.to_lower().strip_edges() == resposta.to_lower().strip_edges():
			return true
	return false

func executar_funcao_personalizada():
	match area_id:
		"Porta_Laboratorio":
			print("Abrindo porta magnética...")
		"Painel_Controle":
			print("Ativando energia do elevador...")
