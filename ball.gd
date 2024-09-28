extends Area2D
@export var original_speed = 400
var speed = 400  # Pixels per second
var velocity = Vector2.ZERO
var screen_size
var margin = 50  # Adjust this value as needed

var player1score = 0
var player2score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()  # Initialize random number generator
	screen_size = get_viewport_rect().size
	new_direction()
	connect("area_entered", Callable(self, "_on_area_entered"))
	update_score_label()

func update_score_label():
	get_parent().get_node("scores").get_node("player1score").text = str(player1score)
	get_parent().get_node("scores").get_node("player2score").text = str(player2score)

func _on_area_entered(_area):
	# Handle collision with other areas
	speed += 50
	velocity = Vector2(velocity.x * -1, randf_range(screen_size.y*-1/2, screen_size.y/2)).normalized() * speed 
	print(velocity)

func reset_ball():
	speed = original_speed
	new_direction()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta

	# TODO: add scores
	if position.x <= 0 + margin:
		player2score += 1
		update_score_label()
		reset_ball()
	if position.x >= screen_size.x - margin:
		player1score += 1
		update_score_label()
		reset_ball()

	if position.y <= 0 + margin or position.y >= screen_size.y - margin:
		velocity.y *= -1
	

# Set a new random direction for the ball
func new_direction():
	position = Vector2(screen_size.x / 2, screen_size.y / 2)
	var x_direction = randf_range(-0.8, 0.8)
	var y_direction = randf_range(-0.2, 0.2)
	velocity = Vector2(x_direction, y_direction).normalized() * speed
