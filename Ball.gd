extends KinematicBody2D

var speed : int = 800
var texture : Texture = preload("res://sprites/ball.png")
var texture_alt : Texture = preload("res://sprites/ball_alt.png")

var vel : Vector2
var is_slow : bool = false

onready var sprite : Sprite = $Sprite

func _ready():
	var random = RandomNumberGenerator.new()
	random.randomize()
	vel = Vector2(-speed, random.randfn() * 400)

func _physics_process(delta):
	var paddle = get_parent().get_node("Paddle")
	if self.transform.origin.x > 1024:
		if is_slow:
			paddle.score += 1
			print("Score: ", paddle.score)
		queue_free()
		
	if self.transform.origin.x < 0:
		if not is_slow:
			paddle.misses += 1
			print("Misses: ", paddle.misses)
		queue_free()
	
	var collision = move_and_collide(vel * delta)
	if collision:
		vel = vel.bounce(collision.normal)
		
		var collider_name = collision.collider.name

		if collider_name == "Paddle":
			vel.x = abs(vel.x)
			if paddle.is_slow:
				is_slow = true
				vel /= 2
				sprite.texture = texture_alt
