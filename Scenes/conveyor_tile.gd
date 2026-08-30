@tool
extends Area2D

@export var direction: DIRECTIONS = DIRECTIONS.UP:
	set(value):
		direction = value
		_change_sprite()

@onready var sprites: Node2D = $Sprites

enum DIRECTIONS {UP,DOWN,LEFT,RIGHT}

func _ready() -> void:
	_change_sprite()

func _change_sprite():
	if not is_node_ready():
		return
		
	for i in sprites.get_child_count():
		sprites.get_child(i).visible = i == direction


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.conveyorDirection = _get_vector(direction)
		body.is_conveyor = true

func _get_vector(selectedDirection:DIRECTIONS):
	match selectedDirection:
		DIRECTIONS.UP: return Vector2.UP
		DIRECTIONS.DOWN: return Vector2.DOWN
		DIRECTIONS.RIGHT: return Vector2.RIGHT
		DIRECTIONS.LEFT: return Vector2.LEFT


func _on_body_exited(body):
	if body.is_in_group("player"):
		body.conveyorDirection = Vector2.ZERO
		body.is_conveyor = false
