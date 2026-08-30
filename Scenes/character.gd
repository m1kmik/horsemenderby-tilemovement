extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D 
@onready var raycast_2d: RayCast2D =$RayCast2D

const TILE_SIZE= 16
const SPEED= 600

var onMove = false
var currentDirection: Vector2
var lastDirection: Vector2
var conveyorDirection: Vector2
var iceDirection: Vector2
var is_ice = false
var is_conveyor = false

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta):
	if onMove:
		return
	
	if conveyorDirection:
		_conveyor_move()
	
	if iceDirection:
		_ice_move()
	
	_normal_movement()
	_set_animation()
	lastDirection = currentDirection

func _conveyor_move():
	raycast_2d.target_position = conveyorDirection * TILE_SIZE
	raycast_2d.force_raycast_update()
	
	if raycast_2d.is_colliding():
		conveyorDirection = Vector2.ZERO
	else:
		_move_to(global_position + conveyorDirection * TILE_SIZE)
		

func _ice_move():
	raycast_2d.target_position = iceDirection * TILE_SIZE
	raycast_2d.force_raycast_update()
	
	if raycast_2d.is_colliding():
		is_ice = false
		iceDirection = Vector2.ZERO
		
	else:
		_move_to(global_position + iceDirection * TILE_SIZE)
	

func _normal_movement():
	var direction: Vector2
	if is_ice == true:
			iceDirection = currentDirection
			direction = Vector2.ZERO
			
	elif is_conveyor == true:
		direction = Vector2.ZERO
		
	else:
		if Input.is_action_pressed("ui_up"):
			direction = Vector2.UP
		elif Input.is_action_pressed("ui_down"):
			direction = Vector2.DOWN
		elif Input.is_action_pressed("ui_right"):
			direction = Vector2.RIGHT
		elif Input.is_action_pressed("ui_left"):
			direction = Vector2.LEFT
		
		currentDirection = direction
	
	
	if direction:
		raycast_2d.target_position = direction * TILE_SIZE
		raycast_2d.force_raycast_update()
		
		if raycast_2d.is_colliding(): return
		var targetPosition = global_position + direction * TILE_SIZE
		_move_to(targetPosition)
		

func _move_to(targetPosition):
	if not targetPosition:
		return
		
	onMove = true
	
	var tween = create_tween()
	tween.tween_property(self, "global_position", targetPosition, 0.3)
	await tween.finished
	
	onMove = false

func _set_animation():
	if conveyorDirection.x > 0:
		animated_sprite_2d.play("idle_right")
	elif conveyorDirection.x < 0:
		animated_sprite_2d.play("idle_left")
	elif conveyorDirection.y < 0:
		animated_sprite_2d.play("idle_up")
	elif conveyorDirection.y > 0:
		animated_sprite_2d.play("idle_down")
		
	elif iceDirection.x > 0:
		animated_sprite_2d.play("idle_right")
	elif iceDirection.x < 0:
		animated_sprite_2d.play("idle_left")
	elif iceDirection.y < 0:
		animated_sprite_2d.play("idle_up")
	elif iceDirection.y > 0:
		animated_sprite_2d.play("idle_down")
		
		
	elif currentDirection.x > 0:
		animated_sprite_2d.play("walk_right")
	elif currentDirection.x < 0:
		animated_sprite_2d.play("walk_left")
	elif currentDirection.y < 0:
		animated_sprite_2d.play("walk_up")
	elif currentDirection.y > 0:
		animated_sprite_2d.play("walk_down")
		
		
	else:
		if lastDirection.x > 0:
			animated_sprite_2d.play("idle_right")
		elif lastDirection.x < 0:
			animated_sprite_2d.play("idle_left")
		elif lastDirection.y < 0:
			animated_sprite_2d.play("idle_up")
		elif lastDirection.y > 0:
			animated_sprite_2d.play("idle_down")
