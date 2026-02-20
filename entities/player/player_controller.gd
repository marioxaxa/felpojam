extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.03
const ALCANCE_CARIMBADA = 2.0

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var ui_carimbo = $CarimboUi

var carimbada_scene = preload("res://common/components/carimbada.tscn")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if ui_carimbo.visible:
		return
	if event.is_action_pressed("mouse_left"):
		carimbar()
	if event.is_action_pressed("mouse_right"):
		ui_carimbo.abrir()

func _unhandled_input(event):
	if ui_carimbo.visible:
		return
	
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(80))

func _physics_process(delta: float) -> void:
	
	if ui_carimbo.visible:
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = 0
		velocity.z = 0

	move_and_slide()

func carimbar():
	
	var space_state = get_world_3d().direct_space_state
	var mouse_pos = get_viewport().get_mouse_position()
	
	var origin = camera.project_ray_origin(mouse_pos)
	var end = origin + camera.project_ray_normal(mouse_pos) * ALCANCE_CARIMBADA
	
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	var result = space_state.intersect_ray(query)
	
	if result:
		criar_instancia_carimbo(result.position, result.normal)
		var dados_carimbo = {
			"pos": result.position,
			"normal": result.normal,
			"texto": SaveLoad.SaveFileData.texto_carimbo_atual 
		}
		SaveLoad.SaveFileData.carimbos_dados.append(dados_carimbo)
		SaveLoad._save()

func criar_instancia_carimbo(pos: Vector3, normal: Vector3, texto: String = ""):
	var carimbo_scene = preload("res://common/components/carimbada.tscn")
	var instancia = carimbo_scene.instantiate()
	
	get_tree().root.add_child(instancia)
	instancia.global_position = pos
	
	var axis_y = normal
	var up_dir = -camera.global_transform.basis.z
	if abs(normal.dot(Vector3.UP)) < 0.9:
		up_dir = Vector3.UP
	var axis_x = up_dir.cross(axis_y).normalized() 
	var axis_z = axis_x.cross(axis_y).normalized()
	instancia.global_transform.basis = Basis(axis_x, axis_y, axis_z)

	var texto_final = texto
	if texto_final == "":
		texto_final = SaveLoad.SaveFileData.texto_carimbo_atual
		
	instancia.configurar_carimbo(texto_final)
