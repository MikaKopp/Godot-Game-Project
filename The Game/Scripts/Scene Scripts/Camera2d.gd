extends Camera2D

# Movement and zoom settings
@export var move_speed: float = 800.0  # Speed of camera movement
@export var edge_pan_speed: float = 800.0  # Speed of edge panning
@export var edge_pan_margin: float = 20.0  # Margin for edge panning (in pixels)
@export var zoom_speed: float = 0.2  # Speed of zooming
@export var min_zoom: Vector2 = Vector2(0.2, 0.2)  # Minimum zoom level
@export var max_zoom: Vector2 = Vector2(2, 2)  # Maximum zoom level

# Variables for input
var zoom_target: Vector2 = Vector2.ONE  # Target zoom level
var edge_pan_enabled: bool = true  # Toggle edge panning
var camera_active: bool = true  # New flag to enable/disable camera movement

func _ready():
	# Initialize zoom to current zoom level
	zoom_target = zoom

func _process(delta):
	if camera_active:  # Check if the camera is active
		handle_movement(delta)
		handle_edge_panning(delta)
		handle_zoom(delta)

# Handle movement with WASD keys
func handle_movement(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	
	# Normalize and apply movement
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	global_position += direction * move_speed * delta

# Handle mouse edge panning
func handle_edge_panning(delta):
	if not edge_pan_enabled:
		return

	var viewport_size = get_viewport().get_visible_rect().size
	var mouse_position = get_viewport().get_mouse_position()
	var edge_direction = Vector2.ZERO

	if mouse_position.x <= edge_pan_margin:
		edge_direction.x -= 1
	if mouse_position.x >= viewport_size.x - edge_pan_margin:
		edge_direction.x += 1
	if mouse_position.y <= edge_pan_margin:
		edge_direction.y -= 1
	if mouse_position.y >= viewport_size.y - edge_pan_margin:
		edge_direction.y += 1

	if edge_direction != Vector2.ZERO:
		edge_direction = edge_direction.normalized()
	global_position += edge_direction * edge_pan_speed * delta

# Handle smooth zooming with mouse wheel
func handle_zoom(delta):
	if Input.is_action_just_pressed("zoom_in"):
		zoom_target -= Vector2(zoom_speed, zoom_speed)
	elif Input.is_action_just_pressed("zoom_out"):
		zoom_target += Vector2(zoom_speed, zoom_speed)

	# Clamp zoom to allowed range
	zoom_target.x = clamp(zoom_target.x, min_zoom.x, max_zoom.x)
	zoom_target.y = clamp(zoom_target.y, min_zoom.y, max_zoom.y)

	# Smoothly interpolate to target zoom
	zoom = lerp(zoom, zoom_target, 0.1)

# Input mapping for smooth zoom
func _input(event):
	if event is InputEventMouseMotion:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_UP:
		Input.action_press("zoom_in")
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		Input.action_press("zoom_out")
