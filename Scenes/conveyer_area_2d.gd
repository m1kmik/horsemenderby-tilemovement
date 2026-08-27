extends Area2D
class_name ConveyerArea2D

@export var horizontal_speed: float = 1.0
var objects_array: Array[Node2D] = []
var objects_speed: Array[float] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	
	body_entered.connect(_object_exited)
	body_exited.connect(_object_entered)
	

func _physics_process(delta):
	for i in objects_array.size():
		if objects_speed[i] != horizontal_speed:
			objects_array[i].conveyer_velocity += horizontal_speed
			objects_speed[i] = horizontal_speed
		elif !objects_speed[i] != 0.0:
			objects_array[i].conveyer_velocity -= horizontal_speed
			objects_speed[i] = 0.0

func _object_entered(object: Node2D) -> void:
	if "conveyer_velocity" in object:
		objects_array.append(object)
		objects_speed.append(0.0)
	


func _object_exited(object: Node2D) -> void:
	if "conveyer_velocity" in object and objects_array.has(object):
		var object_pos: int = objects_array.find(object)
		if objects_speed[object_pos] != 0.0:
			objects_array[object_pos].conveyer_velocity -= horizontal_speed
		objects_array.remove_at(object_pos)
		objects_speed.remove_at(object_pos)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
