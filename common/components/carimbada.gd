extends Node3D

var texto_interno: String = ""

func configurar_carimbo(texto_recebido: String):
	texto_interno = texto_recebido
	var v_port = get_node_or_null("SubViewport")
	var dcl = get_node_or_null("Decal")
	var lbl = get_node_or_null("SubViewport/Label")
	var rect = get_node_or_null("SubViewport/ColorRect")
	
	if not v_port or not lbl or not dcl:
		return

	dcl.visible = false
	lbl.text = texto_recebido

	var detector = get_node_or_null("AreaDetector")
	if detector:
		
		await get_tree().physics_frame
		await get_tree().physics_frame
		
		var areas_sobrepostas = detector.get_overlapping_areas()
		
		for area in areas_sobrepostas:
			if area.has_method("verificar_resposta"):
				if area.verificar_resposta(texto_recebido):
					if rect: rect.color = Color.GREEN
					area.executar_funcao_personalizada()
					break

	v_port.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	
	var img = v_port.get_texture().get_image()
	var tex_estatica = ImageTexture.create_from_image(img)
	
	dcl.texture_albedo = tex_estatica
	dcl.visible = true
	
	v_port.render_target_update_mode = SubViewport.UPDATE_DISABLED
	v_port.queue_free()

func obter_texto() -> String:
	return texto_interno
