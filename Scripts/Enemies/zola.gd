extends CharacterBody2D

#Necesitamos una referencia a las animaciones
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

#Referencia al Timer que controla cuanto tiempo espera escondido antes de atacar
@onready var timer: Timer = $Timer

#Escena del proyectil que va a disparar (arrastra aquí tu escena de proyectil, opcional)
@export var projectile_scene: PackedScene

#Rango de tiempo aleatorio que Zola permanece escondido entre ataques
@export var hidden_time_min: float = 1.5
@export var hidden_time_max: float = 3.0

#Cuanto tiempo se queda con la cabeza afuera atacando antes de volver a meterse
@export var attack_duration: float = 0.6

#Se ejecuta una sola vez cuando inicia el juego
func _ready() -> void:
	animated_sprite_2d.play("hidden")
	timer.timeout.connect(_on_timer_timeout)
	_start_hidden_timer()

#Reinicia el temporizador con un tiempo aleatorio (para que no sea predecible)
func _start_hidden_timer() -> void:
	timer.wait_time = randf_range(hidden_time_min, hidden_time_max)
	timer.start()

#Se llama cuando termina el tiempo escondido: arranca la secuencia de ataque
func _on_timer_timeout() -> void:
	attack_sequence()

#Secuencia: sale del agua (cambia a sprite "attack"), dispara y se vuelve a meter
func attack_sequence() -> void:
	#Sale del agua y dispara
	animated_sprite_2d.play("attack")
	shoot()

	#Se queda un momento con la cabeza afuera antes de sumergirse otra vez
	await get_tree().create_timer(attack_duration).timeout

	#Se mete de nuevo al agua
	animated_sprite_2d.play("hidden")
	_start_hidden_timer()

#Crear metodo para disparar el proyectil hacia el jugador
func shoot() -> void:
	if projectile_scene == null:
		return

	var projectile = projectile_scene.instantiate()
	get_parent().add_child(projectile)
	projectile.global_position = global_position

	#Busca al jugador por grupo "player" y calcula direccion hacia el
	var player = get_tree().get_first_node_in_group("player")
	if player and projectile.has_method("set_direction"):
		var direction_to_player: Vector2 = (player.global_position - global_position).normalized()
		projectile.set_direction(direction_to_player)
