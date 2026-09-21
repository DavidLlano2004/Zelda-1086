class_name Screen_Transition
extends Node2D

#Create references
@onready var camera_2d: Camera2D = $".."
@onready var player: Player = $"../../Player"

var moving_camera: bool = false

@onready var area_2d_up: Area2D = $Area2D_UP
@onready var area_2d_down: Area2D = $Area2D_DOWN
@onready var area_2d_left: Area2D = $Area2D_LEFT
@onready var area_2d_right: Area2D = $Area2D_RIGHT

func disable_borders()->void:
	area_2d_up.set_deferred("monitoring" ,false)
	area_2d_down.set_deferred("monitoring" ,false)
	area_2d_left.set_deferred("monitoring" ,false)
	area_2d_right.set_deferred("monitoring" ,false)
	
func enable_borders()->void:
	area_2d_up.set_deferred("monitoring" ,true)
	area_2d_down.set_deferred("monitoring" ,true)
	area_2d_left.set_deferred("monitoring" ,true)
	area_2d_right.set_deferred("monitoring" ,true)


func _on_area_2d_up_body_entered(body: Node2D) -> void:
	#1. Verificar el ingreso en el body
	if body.name == "Player" and not moving_camera:
		moving_camera = true
	
	#2. Deshabilitar los bordes
	disable_borders()
	
	#3. Llamar la función del personaje
	await player.move_transition_player(Vector2.UP , 20)
	
	#4. Crear la nueva posición de la camara
	var new_position_camera = camera_2d.position + Vector2(0,-176)
	
	#5. Crear trancisión,utilizando tween
	var tween = create_tween()
	tween.tween_property(camera_2d,"position" , new_position_camera , 0.8)
	await tween.finished
	#6. Habilitar de nuevo los bordes
	enable_borders()
	
	moving_camera = false
	
	player.can_move = true
	
	print("UP" , body.name)

func _on_area_2d_down_body_entered(body: Node2D) -> void:
	
	#1. Verificar el ingreso en el body
	if body.name == "Player" and not moving_camera:
		moving_camera = true
	
	#2. Deshabilitar los bordes
	disable_borders()
	
	#3. Llamar la función del personaje
	await player.move_transition_player(Vector2.DOWN , 20)
	
	#4. Crear la nueva posición de la camara
	var new_position_camera = camera_2d.position + Vector2(0,176)
	
	#5. Crear trancisión,utilizando tween
	var tween = create_tween()
	tween.tween_property(camera_2d,"position" , new_position_camera , 0.8)
	await tween.finished
	#6. Habilitar de nuevo los bordes
	enable_borders()
	
	moving_camera = false
	
	player.can_move = true
	
	print("DOWN" , body.name)


func _on_area_2d_left_body_entered(body: Node2D) -> void:
	#1. Verificar el ingreso en el body
	if body.name == "Player" and not moving_camera:
		moving_camera = true
	
	#2. Deshabilitar los bordes
	disable_borders()
	
	#3. Llamar la función del personaje
	await player.move_transition_player(Vector2.LEFT , 20)
	
	#4. Crear la nueva posición de la camara
	var new_position_camera = camera_2d.position + Vector2(-256,0)
	
	#5. Crear trancisión,utilizando tween
	var tween = create_tween()
	tween.tween_property(camera_2d,"position" , new_position_camera , 0.8)
	await tween.finished
	#6. Habilitar de nuevo los bordes
	enable_borders()
	
	moving_camera = false
	
	player.can_move = true
	
	print("LEFT" , body.name)
	
	
func _on_area_2d_right_body_entered(body: Node2D) -> void:
	#1. Verificar el ingreso en el body
	if body.name == "Player" and not moving_camera:
		moving_camera = true
	
	#2. Deshabilitar los bordes
	disable_borders()
	
	#3. Llamar la función del personaje
	await player.move_transition_player(Vector2.RIGHT , 20)
	
	#4. Crear la nueva posición de la camara
	var new_position_camera = camera_2d.position + Vector2(256,0)
	
	#5. Crear trancisión,utilizando tween
	var tween = create_tween()
	tween.tween_property(camera_2d,"position" , new_position_camera , 0.8)
	await tween.finished
	#6. Habilitar de nuevo los bordes
	enable_borders()
	
	moving_camera = false
	
	player.can_move = true
	
	print("RIGHT" , body.name)
