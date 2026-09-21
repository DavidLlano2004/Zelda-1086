extends Area2D

#Velocidad a la que viaja el proyectil
@export var SPEED: float = 80.0

#Direccion hacia la que se mueve, se define desde afuera con set_direction()
var direction: Vector2 = Vector2.ZERO

#Referencia al notificador que avisa cuando el proyectil sale de pantalla
@onready var screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

#Referencia a las animaciones (alterna entre los colores mientras viaja)
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

#Se ejecuta una sola vez cuando el proyectil aparece
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	screen_notifier.screen_exited.connect(_on_screen_exited)
	animated_sprite_2d.play("fly")

#Crear metodo para asignar la direccion del disparo desde afuera (lo llama zola.gd)
func set_direction(new_direction: Vector2) -> void:
	direction = new_direction
	rotation = direction.angle()

#Se evalua en todo momento
func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta

#Se destruye solo cuando sale de la pantalla, para no acumular basura
func _on_screen_exited() -> void:
	queue_free()

#Si choca contra el jugador, le hace daño y se destruye
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and body.has_method("take_damage"):
		body.take_damage(1)
	queue_free()
