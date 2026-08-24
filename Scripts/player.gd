extends CharacterBody2D

@export var move_speed: float = 200
var conveyer_velocity: Vector2 = Vector2(1,0)

const SPEED = 600.0
const JUMP_VELOCITY = -400.0

	
func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	
	
	process_movement()
	var tilemap: TileMapLayer = get_tree().get_first_node_in_group("tilemap")
	var cell :Vector2i= tilemap.local_to_map(position)
	var data: TileData = tilemap.get_cell_tile_data(cell)
	
	if data:
		var conveyer_right = data.get_custom_data("conveyer_right")
		if conveyer_right != Vector2.ZERO:
			velocity += conveyer_velocity * SPEED
	move_and_slide()
	
func process_movement() -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	
	velocity = direction * SPEED


func get_tile_speed() -> Variant:
	var tilemap: TileMapLayer = get_tree().get_first_node_in_group("tilemap")
	
	if not tilemap:
		return null
	
	var cell :Vector2i= tilemap.local_to_map(position)
	var data: TileData = tilemap.get_cell_tile_data(cell)
	
	if data:
		var conveyer_right = data.get_custom_data("conveyer_right")
		if conveyer_right != Vector2.ZERO:
			velocity += conveyer_velocity * velocity
		
	return null
