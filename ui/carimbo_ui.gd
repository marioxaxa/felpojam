extends CanvasLayer

@onready var input = $CenterContainer/Panel/MarginContainer/VBoxContainer/TextoInput

func _ready():
	hide() 
	input.text_changed.connect(_on_text_changed)

func _on_text_changed(new_text: String):
	input.text = new_text.to_upper()
	input.caret_column = input.text.length() 

func _input(event):
	if event.is_action_pressed("cancel") and visible:
		fechar()

func abrir():
	show()
	input.grab_focus()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE 

func fechar():
	hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_botao_cancelar_pressed():
	fechar()

func _on_botao_salvar_pressed():
	SaveLoad.SaveFileData.texto_carimbo_atual = input.text
	SaveLoad._save()
	fechar()
