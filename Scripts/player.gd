extends CharacterBody2D

@export var move_speed: float = 200
var conveyer_velocity_right: Vector2 = Vector2(1,0)
var conveyer_velocity_left: Vector2 = Vector2(-1,0)
var conveyer_velocity_up: Vector2 = Vector2(0,-1)
var conveyer_velocity_down: Vector2 = Vector2(0,1)



var SPEED = 600.0
const JUMP_VELOCITY = -400.0


var is_sliding: bool = false
var on_ice: bool = false
var ice_slide_direction = Vector2.ZERO

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	
	
	process_movement()
	get_tile_speed()
	move_and_slide()
	
func process_movement() -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	if is_sliding == false:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
		


func get_tile_speed() -> Variant:
	var tilemap: TileMapLayer = get_tree().get_first_node_in_group("tilemap")
	
	if not tilemap:
		is_sliding = false
		return null
	
	var cell :Vector2i= tilemap.local_to_map(position)
	var data: TileData = tilemap.get_cell_tile_data(cell)
	
	if data:
		var conveyer_right = data.get_custom_data("conveyer_right")
		var conveyer_left = data.get_custom_data("conveyer_left")
		var conveyer_up = data.get_custom_data("conveyer_up")
		var conveyer_down = data.get_custom_data("conveyer_right")
		var regain_control = data.get_custom_data("regain_control")
		
		if conveyer_right != Vector2.ZERO:
			velocity += conveyer_velocity_right * SPEED 
			is_sliding = true
		elif conveyer_left != Vector2.ZERO:
			velocity += conveyer_velocity_left * SPEED 
			is_sliding = true
		elif conveyer_up != Vector2.ZERO:
			velocity += conveyer_velocity_up * SPEED 
			is_sliding = true
		elif conveyer_down != Vector2.ZERO:
			velocity += conveyer_velocity_down * SPEED 
			is_sliding = true
			
		elif regain_control != Vector2.ZERO or conveyer_right == Vector2.ZERO or conveyer_right == Vector2.ZERO:
			is_sliding = false
			
		
	return null
